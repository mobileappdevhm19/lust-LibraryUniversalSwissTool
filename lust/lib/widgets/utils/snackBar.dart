import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*class SnackBarWidget extends StatefulWidget {
  @override
  _SnackBarWidgetState createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      action: SnackBarAction(label: "keloke", onPressed: null),
      content: Text("Hola buen dia"),
    );
  }
}*/


class SnackBarWidget extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return   SnackBar(
      action: SnackBarAction(label: "keloke", onPressed: null),
      content: Text("Hola buen dia"),
    );
  }
}
