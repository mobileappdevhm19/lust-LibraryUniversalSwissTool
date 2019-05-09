import 'package:flutter/material.dart';

abstract class StatefulPage extends StatefulWidget {

  StatefulPage({this.title, this.icon});

  final String title;
  final icon;
}