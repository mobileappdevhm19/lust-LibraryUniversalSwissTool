import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lust/widgets/loginPage/buttonLogIn.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _title = "LUST - LibUniversalSwissTool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //PENDING: add a circular progress/similar indicator
            TextBox.getTextBox(context, "E-mail",
                "Do you already have an account?", Icons.email),
            TextBox.getTextBox(context, "Password", "123456", Icons.security),
            ButtonLogin(
                buttonText: "Log in",
                whichButton: true,
                buttonColor: Colors.blue),

            /*ButtonLogin(
                buttonText: "Register",
                whichButton: false,
                buttonColor: Colors.red)
            //TOP of the SCREEN: app icon!!*/
          ],
        )));
  }
}
