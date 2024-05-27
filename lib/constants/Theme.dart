
import 'package:flutter/material.dart';

class ArgonColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color initial = Color.fromRGBO(23, 43, 77, 1.0);

  static const Color primary = Color.fromRGBO(94, 114, 228, 1.0);

  static const Color secondary = Color.fromRGBO(247, 250, 252, 1.0);

  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);

  static const Color info = Color.fromRGBO(17, 205, 239, 1.0);

  static const Color error = Color.fromRGBO(245, 54, 92, 1.0);

  static const Color success = Color.fromRGBO(45, 206, 137, 1.0);

  static const Color warning = Color.fromRGBO(251, 99, 64, 1.0);

  static const Color header = Color.fromRGBO(82, 95, 127, 1.0);

  static const Color bgColorScreen = Color.fromRGBO(248, 249, 254, 1.0);

  static const Color border = Color.fromRGBO(202, 209, 215, 1.0);

  static const Color inputSuccess = Color.fromRGBO(123, 222, 177, 1.0);

  static const Color inputError = Color.fromRGBO(252, 179, 164, 1.0);

  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);

  static const Color text = Color.fromRGBO(50, 50, 93, 1.0);
}

final ThemeData myTheme = ThemeData(
  // Define the primary color of your app
  primaryColor: Colors.blue,
  // Define the button theme
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue, // Background color of buttons
    textTheme: ButtonTextTheme.primary, // Text color of buttons
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(8.0), // Adjust according to your preference
    ),
  ),
);

RaisedButton(
    {required Color textColor,
    required Color color,
    required Null Function() onPressed,
    required RoundedRectangleBorder shape,
    required Padding child}) {
  Widget customButton({
    required String text,
    required VoidCallback onPressed,
    required Color textColor,
    required Color buttonColor,
    required bool useRaisedButton,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

FlatButton(
    {required Color textColor,
    required Color color,
    required Null Function() onPressed,
    required RoundedRectangleBorder shape,
    required Padding child}) {

      return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      child: child,
    );
  }

