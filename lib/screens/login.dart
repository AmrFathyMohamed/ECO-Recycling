// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../constants/Theme.dart';

// //widgets
// import '../widgets/navbar.dart';
// import '../widgets/input.dart';

// import '../widgets/drawer.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool _checkboxValue = false;

//   final double height = window.physicalSize.height;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: Navbar(transparent: true, title: ""),
//         extendBodyBehindAppBar: true,
//         drawer: ArgonDrawer(currentPage: "Account"),
//         body: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("assets/img/recycling-garbage.jpg"),
//                       fit: BoxFit.fitHeight)),
//             ),
//             SafeArea(
//               child: ListView(children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: 60, left: 24.0, right: 24.0, bottom: 60),
//                   child: Card(
//                       elevation: 5,
//                       clipBehavior: Clip.antiAlias,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25.0),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                               height: MediaQuery.of(context).size.height * 0.20,
//                               decoration: BoxDecoration(
//                                   color: ArgonColors.white,
//                                   border: Border(
//                                       bottom: BorderSide(
//                                           width: 0.5,
//                                           color: ArgonColors.muted))),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Center(
//                                     child: Padding(
//                                       padding: EdgeInsets.only(top: 8.0),
//                                       child: Image.asset(
//                                         'assets/eco-icon.png', // Update with your app logo path
//                                         height: 50,
//                                       ),
//                                     ),
//                                   ),
//                                   Center(
//                                       child: Padding(
//                                     padding: EdgeInsets.only(top: 8.0),
//                                     child: Text("Log in with",
//                                         style: TextStyle(
//                                             color: ArgonColors.text,
//                                             fontSize: 16.0)),
//                                   )),
//                                  Center(
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             SizedBox(
//                                               //height: 69,
//                                               child: ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                   foregroundColor:
//                                                       ArgonColors.white,
//                                                   backgroundColor: ArgonColors
//                                                       .primary, // Text color
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             4),
//                                                   ),
//                                                 ),
//                                                 onPressed: () {},
//                                                 child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: 10,
//                                                       top: 10,
//                                                       left: 14,
//                                                       right: 14),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceAround,
//                                                     children: [
//                                                       Icon(
//                                                           FontAwesomeIcons
//                                                               .google,
//                                                           size: 13),
//                                                       SizedBox(width: 5),
//                                                       Text("GOOGLE",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontSize: 13)),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               //height: 36,
//                                               child: ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                   foregroundColor:
//                                                       ArgonColors.white,
//                                                   backgroundColor: ArgonColors
//                                                       .primary, // Text color
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             4),
//                                                   ),
//                                                 ),
//                                                 onPressed: () {},
//                                                 child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       bottom: 10,
//                                                       top: 10,
//                                                       left: 8,
//                                                       right: 8),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceAround,
//                                                     children: [
//                                                       Icon(
//                                                           FontAwesomeIcons
//                                                               .facebook,
//                                                           size: 13),
//                                                       SizedBox(width: 5),
//                                                       Text("FACEBOOK",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontSize: 13)),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       ],
//                               )),
//                           Container(
//                               height: MediaQuery.of(context).size.height * 0.50,
//                               color: Color.fromRGBO(244, 245, 247, 1),
//                               child: Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Center(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: 24.0, bottom: 24.0),
//                                         child: Center(
//                                       child: Padding(
//                                     padding: EdgeInsets.only(top: 8.0),
//                                     child: Text("Or log in with your email",
//                                         style: TextStyle(
//                                             color: ArgonColors.text,
//                                             fontSize: 16.0)),
//                                   )),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.all(8.0),
//                                             child: Input(
//                                                 placeholder: "Email",
//                                                 prefixIcon: Icon(Icons.email)),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.all(8.0),
//                                             child: Input(
//                                                 placeholder: "Password",
//                                                 prefixIcon: Icon(Icons.lock)),
//                                           ),
//                                         ],
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(top: 16),
//                                         child: Center(
//                                           child: FlatButton(
//                                             textColor: ArgonColors.white,
//                                             color: ArgonColors.primary,
//                                             onPressed: () {
//                                               // Respond to button press
//                                               Navigator.pushNamed(
//                                                   context, '/home');
//                                             },
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(25.0),
//                                             ),
//                                             child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     left: 8.0,
//                                                     right: 8.0,
//                                                     top: 8,
//                                                     bottom: 8),
//                                                 child: InkWell(
//                                                   key: const ValueKey(
//                                                       'Sign Up button'),
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 const Login()));
//                                                   },
//                                                   child: const Padding(
//                                                     padding: EdgeInsets.only(
//                                                         left: 16.0,
//                                                         right: 16.0),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Text(
//                                                           'Login',
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         Icon(Icons.login,
//                                                             color:
//                                                                 Colors.white),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                               )
//                         ],
//                       )),
//                 ),
//               ]),
//             )
//           ],
//         ));
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/Theme.dart';

//widgets
import '../widgets/input.dart';
import '../widgets/drawer.dart';

class Login extends StatefulWidget {
  
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final bool _checkboxValue = false;

  final double height = window.physicalSize.height;

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
                      top: 60, left: 24.0, right: 24.0, bottom: 60),
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
                                      //height: 69,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: ArgonColors.danger,
                                          // backgroundColor: ArgonColors.white,
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
                                      //height: 36,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: ArgonColors.primary,
                                          // backgroundColor: ArgonColors.white,
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
                          height: MediaQuery.of(context).size.height * 0.50,
                          color: const Color.fromRGBO(244, 245, 247, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Input(
                                            placeholder: "Email",
                                            prefixIcon: Icon(Icons.email)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Input(
                                            placeholder: "Password",
                                            prefixIcon: Icon(Icons.lock),
                                            password: true),
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
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/home');
                                        },
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
