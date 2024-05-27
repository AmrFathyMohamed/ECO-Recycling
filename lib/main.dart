import 'package:eco/constants/Theme.dart';
import 'package:flutter/material.dart';

// screens
import 'screens/onboarding.dart';
import 'screens/pro.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/register.dart';
import 'screens/articles.dart';
import 'screens/elements.dart';

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
          "/articles": (BuildContext context) => const Articles(),
          "/elements": (BuildContext context) => const Elements(),
          "/account": (BuildContext context) => const Register(),
          "/pro": (BuildContext context) => const Pro(),
        });
  }
}
