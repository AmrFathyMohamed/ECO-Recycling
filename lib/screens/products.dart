// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:eco/widgets/slider-product.dart';
import 'package:flutter/material.dart';

import '../constants/Theme.dart';

//widgets
import '../widgets/drawer.dart';
import '../widgets/navbar.dart';
import '../widgets/card-small.dart';
import 'package:eco/helper/product.dart' as helperProduct;

List<helperProduct.Product> products = helperProduct.getProducts();
List<helperProduct.Product> filteredProducts = [];
List<helperProduct.Product> cartItems = [];


class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: Navbar(
          title: "Products",
          searchBar: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Products"),
        body: Container(
            padding: EdgeInsets.only(top: 24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                SizedBox(height: 16.0),
                  
                  ProductCarousel(imgArray: products),
                SizedBox(height: 16.0),
                   GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.50,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    helperProduct.Product product = products[index];
                    return CardSmall(
                      cta: "View Details",
                      title: product.name,
                      img: product.image,
                      quantity: product.quantity,
                      tap: () {
                        Navigator.pushNamed(context, '/pro');
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
                SizedBox(height: 16.0),
                
                ],
              ),
            )));
  }
  
  void setState(Null Function() param0) {}
}
