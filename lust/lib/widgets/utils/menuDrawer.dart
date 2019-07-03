import 'package:flutter/material.dart';
import 'package:lust/pages/pageContainer.dart';

import 'package:lust/pages/capacityPage.dart';
import 'package:lust/pages/checkinPage.dart';
import 'package:lust/pages/pomodoroPage.dart';
import 'package:lust/pages/tutorFindingPage.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MenuDrawer extends Drawer {

  FirebaseUser user;

  List<PageContainer> pages;

  // Create a menu drawer
  MenuDrawer() {
    FirebaseAuth.instance.currentUser().then((val){
      user = val;
    });

    pages = new List<PageContainer>();

    pages.add(PageContainer(CapacityPage.title, CapacityPage.icon, CapacityPage()));
    pages.add(PageContainer(CheckinPage.title, CheckinPage.icon, CheckinPage()));
    pages.add(PageContainer(TutorFindingPage.title, TutorFindingPage.icon, TutorFindingPage()));
    pages.add(PageContainer(PomodoroPage.title, PomodoroPage.icon, PomodoroPage()));
    // TODO: add your new page here.
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Drawer(
      child: ListView(
        children: _buildListItems(context, pages),
      ),
    );
  }

  // method to switch between the pages
  void _switchPage(BuildContext context, Widget widget) {
    //Navigator.pop(context); //remove a page from the widget stack (close navigation)
    Navigator.pushReplacement(
      //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  // method to create the list for the drawer
  List<Widget> _buildListItems(BuildContext context, List<PageContainer> pages) {
    List<Widget> children = new List<Widget>();
    children.add(UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        child: Icon(
          Icons.verified_user,
          color: Colors.red,
        ),
        backgroundColor: Colors.green,
      ),
      accountName: Text("ID: " + (user.uid != null ? user.uid : "...")),
      accountEmail: Text(user.email != null ? user.email : "..."),
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
