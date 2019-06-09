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

enum LogInOut {SIGNEDIN, NOTSIGNEDIN}

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

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case LogInOut.SIGNEDIN:
        return new CapacityPage(auth: widget.auth);
      case LogInOut.NOTSIGNEDIN:
        return new LoginPage(auth: widget.auth);
    }
  }
}
