import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';
import '../helper/product.dart' as helperProduct; // Import product model and functions

class Cart extends StatelessWidget {
  final List<helperProduct.Product> cartItems;

  const Cart({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Cart",
        transparent: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Cart"),
      body: Stack(
        children: <Widget>[
          // Background image or decoration
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/img/recycling-garbage2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Cart items list
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final product = cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(product.image),
                              ),
                              title: Text(product.name),
                              subtitle: Text(product.price.toString()), // Replace with actual price
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Implement delete action
                                  removeFromCart(product);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.0),
                      // Total amount
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Text(
                            "Total: ${calculateTotal()}",
                            style: TextStyle(
                              color: ArgonColors.primary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Checkout button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Implement checkout action
                              // Navigator.pushNamed(context, '/checkout');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ArgonColors.initial,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "CHECKOUT",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to calculate total price
  double calculateTotal() {
    double total = 0;
    for (var product in cartItems) {
      total += product.price * product.quantity;
    }
    return total;
  }

  // Example method to remove item from cart
  void removeFromCart(helperProduct.Product product) {
    // Implement your logic to remove the product from cartItems
    // Example: This could involve state management or modifying the cartItems list.
  }
}
