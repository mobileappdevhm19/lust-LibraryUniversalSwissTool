import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'package:lust/widgets/loginPage/appLogo.dart';
import 'package:lust/widgets/loginPage/buttonLogIn.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth});

  final BaseAuth auth;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { LOGIN, REGISTER }

class _LoginPageState extends State<LoginPage> {
  String _title = "LUST - LibUniversalSwissTool";
  String _email, _password;
  final _formKey = new GlobalKey<FormState>();
  FormType _formRegister = FormType.LOGIN;

  /*final BaseAuth auth;
  _LoginPageState({this.auth});*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //PENDING: add a circular progress/similar indicator
                //TOP of the SCREEN: app icon!!
                appLogo(),
                /*TextBox.getTextBox(context, "E-mail",
                "Do you already have an account?", Icons.email),
            TextBox.getTextBox(context, "Password", "123456", Icons.security),*/

                ListTile(
                    leading: Icon(Icons.email, size: 35),
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        //labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
                        hintText: "Do you already have an account?",
                        //hintStyle: TextStyle(fontSize: 13, color: Colors.black12),
                      ),
                      validator: (input) =>
                          input.isEmpty ? "You have to write something!" : null,
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _email = input,
                    )),
                ListTile(
                    leading: Icon(Icons.security, size: 35),
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: _title,
                        //labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
                        hintText: "123456",
                        //hintStyle: TextStyle(fontSize: 13, color: Colors.black12),
                      ),
                      validator: (input) =>
                          input.isEmpty ? "You have to write something!" : null,
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _password = input,
                    )),

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

  bool checkTextFields() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("FORM OK: $_email & $_password");
      return true;
    } else {
      print("FORM WRONG: the fields cannot be empty");
      return false;
    }
  }

  Future accountValidation() async {
    String _userID;
    if (checkTextFields()) {
      try {
        if (_formRegister == FormType.LOGIN) {
          _userID = await widget.auth.signIn(_email, _password);
          //String _userID = await auth.signIn(_email, _password);
          print('Signed in: $_userID');
        } else {
          //FormType.REGISTER
          _userID = await widget.auth.signUp(_email, _password);
          print('Registered in: $_userID');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _register() {
    setState(() {
      _formRegister = FormType.REGISTER;
    });

    print("registered");
    accountValidation();
  }

  void _login() {
    setState(() {
      _formRegister = FormType.LOGIN;
    });

    print("login");
    accountValidation();
  }
}
