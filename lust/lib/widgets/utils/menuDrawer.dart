import 'package:flutter/material.dart';

import 'package:lust/pages/statefulPage.dart';

import 'package:lust/pages/capacityPage.dart';

class MenuDrawer {
  static const MockUserInfo userInfo =
      const MockUserInfo(name: "Herbert", email: "123@abc.com");

  // Create a menu drawer
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
            accountName: Text(userInfo.name),
            accountEmail: Text(userInfo.email),
          ),
          _buildListItem(context, CapacityPage()),
          //_buildListItem(context, YOURPAGEGOESHERE),
        ],
      ),
    );
  }

  // method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.pop(
        context); //remove a page from the widget stack (close navigation)
    Navigator.pushReplacement(
        //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  // method to create a tile for a page
  static Widget _buildListItem(BuildContext context, StatefulPage page) {
    return ListTile(
      // menu item CapacityPage
      onTap: () => _switchPage(context, page),
      leading: Icon(page.icon),
      title: Text(page.title),
    );
  }
}

// For mocking user info
class MockUserInfo {
  const MockUserInfo({this.name, this.email});

  final String name;
  final String email;
}
