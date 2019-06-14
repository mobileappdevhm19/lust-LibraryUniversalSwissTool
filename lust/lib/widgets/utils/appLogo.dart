import 'package:flutter/material.dart';

Widget appLogo() {
  return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(image: AssetImage('assets/popper.png')),
        radius: 80,
      ));
}
