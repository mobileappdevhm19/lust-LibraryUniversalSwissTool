import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lust/pages/utils/authProvider.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'package:lust/widgets/utils/appLogo.dart';
import 'package:lust/widgets/loginPage/buttonLogIn.dart';
import 'package:lust/pages/capacityPage/capacityPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignIn});

  final VoidCallback onSignIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { LOGIN, REGISTER }

class _LoginPageState extends State<LoginPage> {
  String _title = "LUST - LibUniversalSwissTool";

  String _email, _password;
  FormType _formRegister = FormType.LOGIN;
  bool _emailChecked;

  String _textSnackBar;
  GlobalKey<ScaffoldState> _scaffState = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  _LoginPageState();

  @override
  /* void initState() {
    super.initState();
    _isEmailVerified();
    print("INIT email VERIFIED: $_emailChecked");
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffState,
        appBar: AppBar(title: Text(_title)),
        //appBar: getAppBar(_title, signOut: false),
        body: Center(
            child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    appLogo(),
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
                          validator: (input) => input.isEmpty
                              ? "You have to write something!"
                              : null,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          onSaved: (input) => _password = input,
                        )),
                    /*SizedBox(
                  height: 40
                ),*/
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
                ))));
  }

  _showSnackBar() {
    _scaffState.currentState.showSnackBar(SnackBar(
      content: Text(_textSnackBar),
    ));
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
        var auth = AuthProvider.of(context).auth;
        if (_formRegister == FormType.LOGIN) {
          _userID = await auth.signIn(_email.toString().trim(),
              _password); //trim(): avoid problems of format w/email
          print('Email verified: $_userID');
          _textSnackBar = "Signed in: $_email";
          widget.onSignIn();

          /*if (await _isEmailVerified()) {
            _userID = await widget.auth.signIn(_email.toString().trim(),
                _password); //trim(): avoid problems of format w/email
            print('Email verified: $_userID');
            _textSnackBar = "Signed in: $_email";
            widget.onSignIn();
          }
          else{
            await widget.auth.sendEmailVerification();

            print('Email not verified!!');
            _textSnackBar = "Email not verified! Please check your mailbox: $_email";
          }*/

        } else {
          //FormType.REGISTER
          _userID = await auth.signUp(_email.toString().trim(), _password);
          //await widget.auth.sendEmailVerification();

          print('Registered in: $_userID');
          _textSnackBar = "Succesfully registered in: $_email";
        }
        //widget.onSignIn();
      } catch (e) {
        print(e);
        _textSnackBar = e.toString();
      }
    }
    _showSnackBar();
  }

  Future<bool> _isEmailVerified() async {
    var auth = AuthProvider.of(context).auth;
    _emailChecked = await auth.isEmailVerified();
    print("EMAIL VERIFIED: $_emailChecked");
    return _emailChecked;
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
