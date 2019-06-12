import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetAppBar extends StatefulWidget {
  final String title;
  final Function function;

  const GetAppBar(this.title, this.function, {Key key})
      : super(key: key);

  @override
  _GetAppBarState createState() {
    return new _GetAppBarState(title, function);
  }
}

class _GetAppBarState extends State<GetAppBar> {
  String title;
  final Function function;

  _GetAppBarState(this.title, this.function);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.power_settings_new), onPressed: function)
      ],
    );
  }

/*Icon getSignOutIcon() {
    if (signOut) {
      try {
        return Icon(Icons.power_settings_new);
      } catch (e) {
        print(e);
      }
    }
  }*/
}
