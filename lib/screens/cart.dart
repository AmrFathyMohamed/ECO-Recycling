import 'package:flutter/material.dart';
import '../constants/Theme.dart';

// Widgets
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(
        title: "Cart",
        transparent: true,
        searchBar: true,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: const ArgonDrawer(currentPage: "Cart"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/img/profile-screen-bg.png"),
                fit: BoxFit.fitWidth,
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
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 0.0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: Column(
                                  children: [
                                    // Example item list using ListView.builder
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 5, // Example cart items count
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: ListTile(
                                            leading: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "https://banner2.cleanpng.com/20181115/tuw/kisspng-recycling-symbol-portable-network-graphics-clip-ar-beaches-go-green-5bedb254ebc102.1666319715423043409657.jpg",
                                              ),
                                            ),
                                            title: Text("Product ${index + 1}"),
                                            subtitle: const Text("20"),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                // Implement delete action
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20.0),
                                    const Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          "Total: 300",
                                          style: TextStyle(
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
                                            foregroundColor: ArgonColors.white,
                                            backgroundColor: ArgonColors.initial,
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
                                        // ElevatedButton(
                                        //   onPressed: () {
                                        //     // Implement continue shopping action
                                        //   },
                                        //   style: ElevatedButton.styleFrom(
                                        //     backgroundColor: ArgonColors.initial,
                                        //     foregroundColor: ArgonColors.white,
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.circular(4.0),
                                        //     ),
                                        //   ),
                                        //   child: const Padding(
                                        //     padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        //     child: Text(
                                        //       "CONTINUE SHOPPING",
                                        //       style: TextStyle(
                                        //         fontWeight: FontWeight.w600,
                                        //         fontSize: 14.0,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
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
}
