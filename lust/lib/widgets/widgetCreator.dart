import 'package:flutter/material.dart';
import 'package:lust/views/capacityPage.dart';
import 'package:lust/widgets/checkInOut.dart';

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
          ListTile( // menu item CapacityPage
            onTap: () => _switchPage(context, CapacityPage()),
            leading: Icon(Icons.equalizer),
            title: Text("Capacity"),
          ),
          ListTile( // menu item Check In/Out
            onTap: () => _switchPage(context, CheckInOut()),
            leading: Icon(Icons.check_circle_outline),
            title: Text("Check In/out"),
          ),
          ListTile( // menu item Secondpage
            //onTap: () => _switchPage(context, CONSTRUCTEROFSECONDPAGE),
            //leading: Icon(ICONFORSECONDPAGE),
            //title: Text("NAMEOFSECONDPAGE"),
          ),
        ],
      ),
    );
  }

  // method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.pop(context); //remove a page from the widget stack (close navigation)
    Navigator.pushReplacement( //replace the top view(widget) from the stack with the new one
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }
}
