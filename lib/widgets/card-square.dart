import 'package:flutter/material.dart';
import '../constants/Theme.dart';

class CardSquare extends StatelessWidget {
  const CardSquare(
      {super.key, this.title = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  final tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: null,
        child: GestureDetector(
          onTap: tap,
          child: Card(
              //elevation: 0.4,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                      flex: 2,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  topRight: Radius.circular(6.0)),
                              image: DecorationImage(
                                image: NetworkImage(img),
                                fit: BoxFit.cover,
                              )))),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(title,
                                style: const TextStyle(
                                    color: ArgonColors.header, fontSize: 13)),
                            Text(cta,
                                style: const TextStyle(
                                    color: ArgonColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ))
                ],
              )),
        ));
  }
}
