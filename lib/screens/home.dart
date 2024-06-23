// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:eco/constants/Theme.dart';

//widgets
import 'package:eco/widgets/navbar.dart';
import 'package:eco/helper/product.dart' as helperProduct;
import 'package:eco/widgets/drawer.dart';

import '../widgets/card-horizontal.dart';
import '../widgets/card-square.dart';

List<helperProduct.Product> products = helperProduct.getProducts();
List<helperProduct.Product> filteredProducts = [];
List<helperProduct.Product> cartItems = [];
String searchQuery = '';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Home",
        searchBar: true,
        categoryOne: "Products",
        categoryTwo: "Notifications",
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Home"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.0),
              CardHorizontal(
                cta: "View article",
                img: "https://www.iiftbangalore.com/blog/wp-content/uploads/2021/12/Recycling-1024x576.jpg",
                tap: () {
                  Navigator.pushNamed(context, '/pro');
                },
              ),
              SizedBox(height: 8.0),
              CardSquare(
                cta: "View article",
                img: "https://www.recyclinghub.in/wp-content/uploads/2023/07/Waste-Management-Company-in-Gujarat.png",
                tap: () {
                  Navigator.pushNamed(context, '/pro');
                },
              ),
              SizedBox(height: 8.0),
              CardHorizontal(
                cta: "View article",
                img: "https://www.iiftbangalore.com/blog/wp-content/uploads/2021/12/Recycling-1024x576.jpg",
                tap: () {
                  Navigator.pushNamed(context, '/pro');
                },
              ),
              SizedBox(height: 8.0),
              CardSquare(
                cta: "View article",
                img: "https://www.recyclinghub.in/wp-content/uploads/2023/07/Waste-Management-Company-in-Gujarat.png",
                tap: () {
                  Navigator.pushNamed(context, '/pro');
                },
              ),
              SizedBox(height: 8.0),
              CardHorizontal(
                cta: "View article",
                img: "https://www.iiftbangalore.com/blog/wp-content/uploads/2021/12/Recycling-1024x576.jpg",
                tap: () {
                  Navigator.pushNamed(context, '/pro');
                },
              ),
              SizedBox(height: 8.0),
              CardSquare(
                cta: "View article",
                img: "https://www.recyclinghub.in/wp-content/uploads/2023/07/Waste-Management-Company-in-Gujarat.png",
                tap: () {
                  Navigator.pushNamed(context, '/pro');
                },
              ),
              SizedBox(height: 8.0),

              SizedBox(height: 8.0),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                children: products.map((product) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
