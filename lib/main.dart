import 'package:eco/constants/Theme.dart';
import 'package:eco/screens/products.dart';
import 'package:eco/screens/login.dart';
import 'package:flutter/material.dart';

// screens
import 'screens/cart.dart';
import 'screens/notifications.dart';
import 'screens/onboarding.dart';
import 'screens/chat.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/register.dart';
import 'screens/rewards.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ECO Recycling',
        theme: myTheme,
        initialRoute: "/onboarding",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => const Onboarding(),
          "/home": (BuildContext context) => const Home(),
          "/profile": (BuildContext context) => const Profile(),
          "/Products": (BuildContext context) => const Products(),
          // "/elements": (BuildContext context) => const Elements(),
          "/registration": (BuildContext context) => const Register(),
          "/login": (BuildContext context) => const Login(),
          "/chat": (BuildContext context) => const Chat(),
          "/cart": (BuildContext context) => const Cart(),
          "/rewards": (BuildContext context) => const Rewards(),
          "/notifications": (BuildContext context) => const Notifications(),


        });
  }
}
