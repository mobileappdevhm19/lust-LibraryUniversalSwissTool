import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'package:lust/widgets/utils/appLogo.dart';
import 'package:lust/widgets/loginPage/buttonLogIn.dart';
import 'capacityPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignIn});

  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { LOGIN, REGISTER }

class _LoginPageState extends State<LoginPage> {
  String _title = "LUST - LibUniversalSwissTool";
  String _email, _password;
  final _formKey = new GlobalKey<FormState>();
  FormType _formRegister = FormType.LOGIN;
  SnackBar _snackBar;

  _LoginPageState();

  /*final BaseAuth auth;
  _LoginPageState({this.auth});*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_title)),
        //appBar: getAppBar(_title, signOut: false),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //PENDING: add a circular progress/similar indicator
                //LOGIN? not register - dialog: do you want to register?
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
                      input.isEmpty ? "Please write your email" : null,
                      keyboardType: TextInputType.emailAddress,
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
                      obscureText: true,
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
          _userID = await widget.auth.signIn(_email.toString().trim(), _password);  //trim(): avoid problems of format w/email
          //String _userID = await auth.signIn(_email, _password);
          print('Signed in Tameos: $_userID');
          _snackBar = new SnackBar(content: Text("Sig "));
        } else {
          //FormType.REGISTER
          _userID = await widget.auth.signUp(_email.toString().trim(), _password);
          print('Registered in: $_userID');
          _snackBar = new SnackBar(content: Text("Registered succesfully in $_email"));
        }
        widget.onSignIn();
      } catch (e) {
        print(e);
        _snackBar=new SnackBar(content: Text(e));
      }
    }
  }

  void _register() {
    setState(() {
      _formRegister = FormType.REGISTER;
    });

    print("registered");
    accountValidation();
    Scaffold.of(context).showSnackBar(_snackBar);
  }
  void _login() {
    setState(() {
      _formRegister = FormType.LOGIN;
    });

    print("login");
    accountValidation();
    Scaffold.of(context).showSnackBar(_snackBar);
  }
}
