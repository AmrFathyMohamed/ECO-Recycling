// ignore_for_file: library_private_types_in_public_api, library_prefixes

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants/Theme.dart';
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';
import '../helper/product.dart' as helperProduct;

class Cart extends StatefulWidget {
  final List<helperProduct.Product>? cartItems;

  const Cart({super.key, this.cartItems});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<helperProduct.Product> cartItems;
  String? userID;  // Add userID as a parameter

  @override
  void initState() {
    super.initState();
        _loadUserData();

    cartItems = widget.cartItems!;
  }
Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString('userid') ?? '0';

    });
    // Call PHP script to fetch user data
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
                                            checkout();
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

  void checkout() async {
    final url = Uri.parse('http://192.168.1.11/ECO/Eco-skydah/Admin Dashboard/FlutterAddOrder.php');  // Replace with your PHP endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'cartItems': cartItems.map((product) => product.toJson()).toList(),
      //'total': calculateTotal(),
      'userID': userID,  // Include userID in the request
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Handle successful checkout
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 'success') {
          // Show success message and clear cart
          setState(() {
            cartItems.clear();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed successfully!')),
          );
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseBody['message']}')),
          );
        }
      } else {
        // Handle server error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Server error. Please try again later.')),
        );
      }
    } catch (e) {
      // Handle network error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
