import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Theme.dart';

import 'drawer-tile.dart';

class ArgonDrawer extends StatefulWidget {
  final String currentPage;

  const ArgonDrawer({super.key, required this.currentPage});

  @override
  _ArgonDrawerState createState() => _ArgonDrawerState();
}

class _ArgonDrawerState extends State<ArgonDrawer> {
  String username = '';
  
  get currentPage => null;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
SizedBox(
  height: MediaQuery.of(context).size.height * 0.1,
  width: MediaQuery.of(context).size.width * 0.85,
  child: SafeArea(
    bottom: false,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/eco-icon.png", height: 40), // Adjust the height to fit the design
            const SizedBox(width: 10), // Space between the image and text
            Text(
              'Hello, $username!',
              style: const TextStyle(
                color: ArgonColors.text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),


        Expanded(
          flex: 2,
          child: ListView(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home") {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  iconColor: ArgonColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    if (currentPage != "Profile") {
                      Navigator.pushReplacementNamed(context, '/profile');
                    }
                  },
                  iconColor: ArgonColors.warning,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.star_border_rounded,
                  onTap: () {
                    if (currentPage != "Rewards") {
                      Navigator.pushReplacementNamed(context, '/rewards');
                    }
                  },
                  iconColor: ArgonColors.warning,
                  title: "Rewards",
                  isSelected: currentPage == "Rewards" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (currentPage != "Products") {
                      Navigator.pushReplacementNamed(context, '/Products');
                    }
                  },
                  iconColor: ArgonColors.primary,
                  title: "Products",
                  isSelected: currentPage == "Products" ? true : false),
                  
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("Setting",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                  icon: Icons.logout,
                  onTap: () {
                    //if (currentPage != "Log out") {
                      Navigator.pushReplacementNamed(context, '/login');
                    //}
                  },
                  iconColor: ArgonColors.info,
                  title: "Log out",
                  isSelected: currentPage == "Log out" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
