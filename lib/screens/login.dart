import 'dart:convert';  // For json decoding
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Theme.dart';

// widgets
import '../widgets/input.dart';
import '../widgets/drawer.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double height = window.physicalSize.height;
  final TextEditingController emailOrUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> _login() async {
    String url = 'http://192.168.1.5/ECO/Eco-skydah/Admin Dashboard/FlutterLogin.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': emailOrUsernameController.text,
          'password': passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Save user data to shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', data['UserData']['FirstName']+ " " + data['UserData']['LastName']);
          await prefs.setString('email', data['UserData']['Email']);
          await prefs.setString('userid', data['UserData']['UserID'].toString());
          await prefs.setString('points', data['UserData']['Points'].toString());
          

          // Navigate to home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else {
          setState(() {
            message = 'Invalid username or password';
          });
        }
      } else {
        setState(() {
          message = 'Failed to connect to server';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e';
        print(message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const ArgonDrawer(currentPage: "Account"),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/recycling-garbage2.jpg"),
                    fit: BoxFit.fitHeight)),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 24.0, right: 24.0, bottom: 20),
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          decoration: const BoxDecoration(
                              color: ArgonColors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: ArgonColors.muted))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image.asset(
                                    'assets/eco-icon.png', // Update with your app logo path
                                    height: 50,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text("Log in with",
                                      style: TextStyle(
                                          color: ArgonColors.text,
                                          fontSize: 16.0)),
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: ArgonColors.danger,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                              left: 14,
                                              right: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(FontAwesomeIcons.google,
                                                  size: 13),
                                              SizedBox(width: 5),
                                              Text("GOOGLE",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: ArgonColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                              left: 8,
                                              right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(FontAwesomeIcons.facebook,
                                                  size: 13),
                                              SizedBox(width: 5),
                                              Text("FACEBOOK",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.60,
                          color: const Color.fromRGBO(244, 245, 247, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 24.0, bottom: 24.0),
                                    child: Center(
                                      child: Text("Or log in with your email",
                                          style: TextStyle(
                                              color: ArgonColors.text,
                                              fontSize: 16.0)),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Input(
                                          placeholder: "Email",
                                          prefixIcon: const Icon(Icons.email),
                                          controller: emailOrUsernameController, validator: (value) {
                                            return null;
                                            },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Input(
                                          placeholder: "Password",
                                          prefixIcon: const Icon(Icons.lock),
                                          password: true,
                                          controller: passwordController, validator: (value) {
                                            return null;
                                            },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ArgonColors.primary,
                                          foregroundColor: ArgonColors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                        ),
                                        onPressed: _login,
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 16.0,
                                              right: 16.0,
                                              top: 12,
                                              bottom: 12),
                                          child: Text("LOGIN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (message.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Center(
                                        child: Text(
                                          message,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Not a member?',
                                        style: TextStyle(
                                            color: Colors.grey[700]),
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/registration');
                                        },
                                        child: const Text(
                                          'Register now',
                                          style: TextStyle(
                                            color: ArgonColors.primary,
                                            fontWeight: FontWeight.bold,
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
