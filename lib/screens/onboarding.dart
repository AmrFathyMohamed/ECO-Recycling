import 'package:flutter/material.dart';

import '../constants/Theme.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/onboard-background.png"),
                  fit: BoxFit.cover))),
      Padding(
        padding:
            const EdgeInsets.only(top: 73, left: 32, right: 32, bottom: 16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset("assets/img/argon-logo-onboarding.png", scale: 1),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 48.0),
                    child: Text.rich(TextSpan(
                      text: "Design System",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 58,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text("Fully coded Flutter widgets and screens.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w200)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    textColor: ArgonColors.text,
                    color: ArgonColors.secondary,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("GET STARTED",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]));
  }
}