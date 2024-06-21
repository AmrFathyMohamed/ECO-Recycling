import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/Theme.dart';

//widgets
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = 'Guest';
  String points = '0';
  String UserID = '0';


  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchUserData();

  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
      points = prefs.getString('points') ?? '0';
      UserID = prefs.getString('userid') ?? '0';

    });

    // Call PHP script to fetch user data
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final response = await http.get(Uri.parse('http://192.168.1.5/ECO/Eco-skydah/Admin Dashboard/FlutterGetUser.php?id=$UserID'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          username = data['UserData']['FirstName']+ " " + data['UserData']['LastName'] ?? 'Guest';
          points = data['UserData']['Points'].toString() ?? '0';
        });
      } else {
        // Handle error response
        print(data['message']);
      }
    } else {
      // Handle HTTP error
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(
        title: "Profile",
        transparent: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: const ArgonDrawer(currentPage: "Profile"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/img/recycling-garbage.jpg"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 90.0),
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
                              elevation: .0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 40.0),
                                          Align(
                                            child: Text(username,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                                fontSize: 28.0)),
                                          ),
                                          const SizedBox(height: 40.0),
                                          Row(
                                            mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                            children: [
                                              const Column(
                                                children: [
                                                  Text("1K",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold)),
                                                  Text("Orders",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                      fontSize: 12.0))
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(points,
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold)),
                                                  const Text("Points",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                      fontSize: 12.0))
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 40.0),
                                          const Align(
                                            child: Text("Qism Bani Sweif, 27",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                                fontSize: 28.0)),
                                          ),
                                          const SizedBox(height: 10.0),
                                          const Align(
                                            child: Text("Beni Suef, Egypt",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                  50, 50, 93, 1),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w200)),
                                          ),
                                          const Divider(
                                            height: 40.0,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              left: 32.0, right: 32.0),
                                            child: Align(
                                              child: Text(
                                                "An artist of considerable range, Abd El Ghany name taken by Melbourne...",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                    82, 95, 127, 1),
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w200)),
                                            ),
                                          ),
                                          const SizedBox(height: 15.0),
                                          const Align(
                                            child: Text("Show more",
                                              style: TextStyle(
                                                color: ArgonColors.primary,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0))),
                                          const SizedBox(height: 25.0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          ),
                          const FractionalTranslation(
                            translation: Offset(0.0, -0.5),
                            child: Align(
                              alignment: FractionalOffset(0.5, 0.5),
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/img/Person.png"),
                                radius: 80.0,
                              ),
                            ))
                        ]),
                    ],
                  ),
                ),
              ]),
          )
        ]));
  }
}
