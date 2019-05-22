import 'package:flutter/material.dart';

class OneLineText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double letterSpacing;
  final double textScaleFactor;
  final bool softWrap;
  final TextAlign textAlign;

  OneLineText({
    this.text = "Default Text",
    this.fontSize = 20.0,
    this.letterSpacing = 2.0,
    this.textScaleFactor = 0.8,
    this.softWrap = true,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return new Text(
      text,
      softWrap: softWrap,
      textAlign: textAlign,
      style: new TextStyle(fontSize: fontSize, letterSpacing: letterSpacing),
      textScaleFactor: textScaleFactor,
    );
  }
}
