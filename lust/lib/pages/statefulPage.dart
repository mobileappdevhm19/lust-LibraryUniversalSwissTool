import 'package:flutter/material.dart';

abstract class StatefulPage extends StatefulWidget {

  final String title;
  final icon;

  StatefulPage(this.title, this.icon);
}
