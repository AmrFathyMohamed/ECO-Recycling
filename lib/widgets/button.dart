import 'package:flutter/material.dart';

const double defaultBorderRadius = 3.0;

class StretchableButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final double? buttonPadding;
  final Color buttonColor, splashColor;
  final Color? buttonBorderColor;
  final List<Widget> children;

  const StretchableButton({
    super.key,
    required this.buttonColor,
    required this.borderRadius,
    required this.children,
    this.splashColor = Colors.transparent,
    this.buttonBorderColor,
    this.onPressed,
    this.buttonPadding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        if (constraints.minWidth == 0) {
          contents.add(const SizedBox.shrink());
        } else {
          contents.add(const Spacer());
        }

        BorderSide bs;
        bs = BorderSide(
          color: buttonBorderColor ?? Colors.transparent,
        );

        return ButtonTheme(
          height: 40.0,
          padding: EdgeInsets.all(buttonPadding ?? 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: buttonColor, // Change text color here if needed
              padding: EdgeInsets.symmetric(vertical: buttonPadding ?? 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: bs,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contents,
            ),
          ),
        );
      },
    );
  }
}
