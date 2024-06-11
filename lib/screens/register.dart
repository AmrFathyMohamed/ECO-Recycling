import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/Theme.dart';
import '../widgets/input.dart';
import '../widgets/drawer.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _checkboxValue = false;
  bool _isLoading = false;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    String url = 'http://192.168.1.5/ECO/Eco-skydah/Admin%20Dashboard/FlutterRegistration.php';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'FirstName': _firstNameController.text.trim(),
          'LastName': _lastNameController.text.trim(),
          'Email': _emailController.text.trim(),
          'Password': _passwordController.text,
          'Type': 'User'
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Registration successful, navigate to home screen or show success message
          Navigator.pushNamed(context, '/login');
        } else {
          // Registration failed, show error message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Error'),
                content: Text(data['error'] ?? 'Unknown error occurred.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle HTTP error
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const ArgonDrawer(currentPage: "Registration"),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/recycling-garbage2.jpg"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 24.0, right: 24.0, bottom: 20),
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            decoration: const BoxDecoration(
                              color: ArgonColors.white,
                              border: Border(
                                bottom: BorderSide(
                                  width: 0.5,
                                  color: ArgonColors.muted,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Image.asset(
                                      'assets/eco-icon.png',
                                      height: 50,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Sign Up with",
                                      style: TextStyle(
                                        color: ArgonColors.text,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: ArgonColors.danger,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 14,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.google,
                                                  size: 13,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "GOOGLE",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
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
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.facebook,
                                                  size: 13,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "FACEBOOK",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
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
                            height: MediaQuery.of(context).size.height * 0.70,
                            color: ArgonColors.whiteOpacity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
                                      child: Center(
                                        child: Text(
                                          "Or Sign Up with your email",
                                          style: TextStyle(
                                            color: ArgonColors.text,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Input(
                                            controller: _firstNameController,
                                            placeholder: "First Name",
                                            prefixIcon: Icon(Icons.person),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your first name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Input(
                                            controller: _lastNameController,
                                            placeholder: "Last Name",
                                            prefixIcon: Icon(Icons.person),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your last name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Input(
                                            controller: _emailController,
                                            placeholder: "Email",
                                            prefixIcon: Icon(Icons.email),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Input(
                                            controller: _passwordController,
                                            placeholder: "Password",
                                            prefixIcon: Icon(Icons.lock),
                                            password: true,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter a password';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 0, bottom: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            activeColor: ArgonColors.primaryGr,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _checkboxValue = newValue!;
                                              });
                                            },
                                            value: _checkboxValue,
                                          ),
                                          const Text(
                                            "I agree with the",
                                            style: TextStyle(
                                              color: ArgonColors.text,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context, '/pro');
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 5),
                                              child: const Text(
                                                "Privacy Policy",
                                                style: TextStyle(
                                                  color: ArgonColors.primaryGr,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16)),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: _checkboxValue ? ArgonColors.primary : ArgonColors.primary.withOpacity(0.5),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25.0),
                                            ),
                                          ),
                                          onPressed: _checkboxValue ? () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            _registerUser();
                                          } : null,
                                          child: Padding(padding:EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 16,
                                            ),
                                            child: _isLoading
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                    ),
                                                  )
                                                : Text(
                                                    "Register",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Already have an account?',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/login');
                                            },
                                            child: const Text(
                                              'Login Now',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

