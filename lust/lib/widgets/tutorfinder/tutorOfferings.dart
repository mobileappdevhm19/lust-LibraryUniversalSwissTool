import 'package:flutter/material.dart';
import 'package:lust/widgets/utils/oneLineText.dart';

class TutorOfferings extends StatelessWidget {
  // a constructor for this class
  TutorOfferings();

  Widget build(context) {
    // Pass the text down to another widget
    return new Column(
      children: <Widget>[
        OneLineText(
          text: "TutorOfferings",
        )
      ],
    );
  }
}
