import 'package:flutter/material.dart';
import 'package:lust/views/capacity.dart';

class WidgetCreator {
  // create a menu drawer
  static Widget getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.verified_user,
                color: Colors.red,
              ),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
