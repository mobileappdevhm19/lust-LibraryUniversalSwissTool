import 'package:flutter/material.dart';

class OneLineText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double letterSpacing;
  final double textScaleFactor;

  OneLineText({
    this.text = "Default Text",
    this.fontSize = 20.0,
    this.letterSpacing = 2.0,
    this.textScaleFactor = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      style: new TextStyle(fontSize: fontSize, letterSpacing: letterSpacing),
      textScaleFactor: textScaleFactor,
    );
  }
}
