import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetAppBar extends StatefulWidget {
  GetAppBar(this._title, {this.signOut});

  String _title;
  bool signOut = true;

  @override
  _GetAppBarState createState() => _GetAppBarState(_title);
}

class _GetAppBarState extends State<GetAppBar> {
  String _title;
  bool signOut = true;

  _GetAppBarState(this._title, {this.signOut});

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      title: Text(_title),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.power_settings_new), onPressed: null)
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
