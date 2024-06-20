import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';
import '../widgets/card-small.dart';
import 'package:eco/helper/product.dart' as helperProduct;
import 'package:eco/screens/cart.dart'; // Import Cart screen

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<helperProduct.Product> products = [];
  List<helperProduct.Product> filteredProducts = [];
  List<helperProduct.Product> cartItems = [];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      List<helperProduct.Product> fetchedProducts =
          await helperProduct.fetchProducts();
      setState(() {
        products = fetchedProducts;
        filteredProducts = products; // Initialize filteredProducts with all products initially
      });
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(
        title: "Products",
        searchBar: true,
        // searchQuery: searchQuery,
        // onSearchChanged: (value) {
        //   setState(() {
        //     searchQuery = value;
        //     filteredProducts = products
        //         .where((product) => product.name
        //             .toLowerCase()
        //             .contains(searchQuery.toLowerCase()))
        //         .toList();
        //   });
        // },
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     onPressed: () {
        //       // Navigate to cart screen
        //       navigateToCartScreen();
        //     },
        //   ),
        // ],
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: const ArgonDrawer(currentPage: "Products"),
      body: Container(
        padding: const EdgeInsets.only(top: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              // Replace with your ProductCarousel widget
              // ProductCarousel(imgArray: products), 
              const SizedBox(height: 16.0),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.50,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  helperProduct.Product product = filteredProducts[index];
                  return CardSmall(
                    cta: "",
                    title: product.name,
                    img: product.image,
                    quantity: product.quantity,
                    tap: () {
                      // Navigate to Cart screen and add product to cart
                      addToCart(product);
                      navigateToCartScreen();
                    },
                    onIncrement: () {
                      setState(() {
                        product.quantity++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        if (product.quantity > 0) product.quantity--;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  // Method to add product to cart
  void addToCart(helperProduct.Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  // Method to navigate to Cart screen
  void navigateToCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cart(cartItems: cartItems),
      ),
    );
  }
}
