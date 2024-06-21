import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';
import '../helper/product.dart' as helperProduct;

class Cart extends StatefulWidget {
  final List<helperProduct.Product> cartItems;

  const Cart({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<helperProduct.Product> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(
        title: "Cart",
        transparent: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: const ArgonDrawer(currentPage: "Cart"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/img/recycling-garbage2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: .0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
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
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Quantity: ${product.quantity}'),
                                                Text('Price: \$${product.price.toStringAsFixed(2)}'),
                                                Text('Total: \$${(product.price * product.quantity).toStringAsFixed(2)}'),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                removeFromCart(product);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20.0),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          "Total: \$${calculateTotal().toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            color: ArgonColors.primary,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Implement checkout action
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ArgonColors.initial,
                                            foregroundColor: ArgonColors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4.0),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
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

  double calculateTotal() {
    double total = 0;
    for (var product in cartItems) {
      total += product.price * product.quantity;
    }
    return total;
  }

  void removeFromCart(helperProduct.Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }
}
