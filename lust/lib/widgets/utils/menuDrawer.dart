import 'package:flutter/material.dart';
import 'package:lust/pages/capacityPage/capacityPage.dart';
import 'package:lust/pages/chatPage/tutorFindingPage.dart';
import 'package:lust/pages/checkinPage/checkinPage.dart';
import 'package:lust/pages/pomodoroPage/pomodoroPage.dart';
import 'package:lust/pages/utils/authProvider.dart';
import 'package:lust/pages/utils/pageContainer.dart';

class MenuDrawer extends Drawer {
  String userID;
  String userEmail;

  List<PageContainer> pages;

  // Create a menu drawer
  MenuDrawer(BuildContext context) {
    userID = "...";
    userEmail = "...";

    AuthProvider.of(context).auth.getCurrentUser().then((user){
      userID = user == null ? "..." : user.uid;
      userEmail = user == null ? "..." : user.email;
    });

    pages = new List<PageContainer>();

    pages.add(
        PageContainer(CapacityPage.title, CapacityPage.icon, CapacityPage()));
    pages
        .add(PageContainer(CheckinPage.title, CheckinPage.icon, CheckinPage()));
    pages.add(PageContainer(
        TutorFindingPage.title, TutorFindingPage.icon, TutorFindingPage()));
    pages.add(
        PageContainer(PomodoroPage.title, PomodoroPage.icon, PomodoroPage()));
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
  static switchPage(BuildContext context, Widget widget) {
    //Navigator.pop(context); //remove a page from the widget stack (close navigation)
    Navigator.pushReplacement(
        //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  // method to create the list for the drawer
  List<Widget> _buildListItems(
      BuildContext context, List<PageContainer> pages) {
    List<Widget> children = new List<Widget>();
    children.add(UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(image: AssetImage('assets/popper.png')),
        radius: 10,
      ),
      //accountName: Text(userID),
      accountName: Text("Locker number: "),
      accountEmail: Text(userEmail),
    ));
    pages.forEach((page) => children.add(ListTile(
          onTap: () => switchPage(context, page.pageObject),
          leading: Icon(page.icon),
          title: Text(page.title),
        )));
    return children;
  }
}
