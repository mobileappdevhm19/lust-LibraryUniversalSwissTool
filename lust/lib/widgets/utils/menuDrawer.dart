import 'package:flutter/material.dart';
import 'package:lust/pages/pageContainer.dart';

import 'package:lust/pages/capacityPage.dart';
import 'package:lust/pages/checkinPage.dart';

class MenuDrawer {
  static const MockUserInfo userInfo = const MockUserInfo(name: "Herbert", email: "123@abc.com");

  // Create a menu drawer
  static Widget getDrawer(BuildContext context) {
    List<PageContainer> pages = new List<PageContainer>();

    pages.add(PageContainer(CapacityPage.title, CapacityPage.icon, CapacityPage()));
    pages.add(PageContainer(CheckinPage.title, CheckinPage.icon, CheckinPage()));
    // TODO: add your new page here.
    // your page must have a "static String title" and a "static IconData icon"
    // use  the following template
    //pages.add(PageContainer(YOURPAGENAME.title, YOURPAGENAME.icon, YOURPAGENAME()));

    return Drawer(
      child: ListView(
        children: _buildListItems(context, pages),
      ),
    );
  }

  // method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.pop(context); //remove a page from the widget stack (close navigation)
    Navigator.pushReplacement(
        //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  // method to create the list for the drawer
  static List<Widget> _buildListItems(BuildContext context, List<PageContainer> pages) {
    List<Widget> children = new List<Widget>();
    children.add(UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        child: Icon(
          Icons.verified_user,
          color: Colors.red,
        ),
        backgroundColor: Colors.green,
      ),
      accountName: Text(userInfo.name),
      accountEmail: Text(userInfo.email),
    ));
    pages.forEach((page) => children.add(
        ListTile(
          onTap: () => _switchPage(context, page.pageObject),
          leading: Icon(page.icon),
          title: Text(page.title),
        )));
    return children;
  }
}

// For mocking user info
class MockUserInfo {
  final String name;
  final String email;

  const MockUserInfo({this.name, this.email});
}
