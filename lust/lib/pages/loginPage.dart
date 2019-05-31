import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lust/widgets/loginPage/appLogo.dart';
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
        body: Form(
            //key: _globalKey,
            child: ListView(
          children: <Widget>[
            //PENDING: add a circular progress/similar indicator
            //TOP of the SCREEN: app icon!!
            appLogo(),
            TextBox.getTextBox(context, "E-mail",
                "Do you already have an account?", Icons.email),
            TextBox.getTextBox(context, "Password", "123456", Icons.security),
            //SizedBox(height: 20, width: double.infinity),
            ButtonLogin(
              buttonText: "Log in",
              whichButton: true,
              buttonColor: Colors.blue,
              function: _login,
            ),
            ButtonLogin(
                buttonText: "Register",
                whichButton: false,
                buttonColor: Colors.red,
                function: _register)
          ],
        )));
  }

  void _register() {
    print("registered");
  }

  void _login() {
    print("login");
  }
}
