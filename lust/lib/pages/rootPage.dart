import 'package:flutter/cupertino.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'capacityPage.dart';
import 'loginPage.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum LogInOut { SIGNEDIN, NOTSIGNEDIN}

class _RootPageState extends State<RootPage> {
  LogInOut authStatus = LogInOut.NOTSIGNEDIN;

  _RootPageState();

  @override
  initState() {
    super.initState();
    widget.auth.getCurrentUser().then((userID) {
      setState(() {
        print("USER ID: $userID");
        authStatus = userID == null ? LogInOut.NOTSIGNEDIN : LogInOut.SIGNEDIN;
      });
    });
  }

  void _onSignedOut() {   //not implemented yet
    setState(() {
      print('CALLBACK: onSignedOut');
      authStatus = LogInOut.NOTSIGNEDIN;
    });
  }

  void _onSignedIn() {
    setState(() {
      print("CALLBACK: onSignedIn");
      authStatus = LogInOut.SIGNEDIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case LogInOut.SIGNEDIN:
        print("CASE 1: signedIn");
        return new CapacityPage(
          auth: widget.auth,
          onSignedOut: _onSignedOut,
        );

      case LogInOut.NOTSIGNEDIN:
        print("CASE 2: notSignedIn");
        return new LoginPage(
            auth: widget.auth,
            onSignIn: _onSignedIn);
    }
  }

}

