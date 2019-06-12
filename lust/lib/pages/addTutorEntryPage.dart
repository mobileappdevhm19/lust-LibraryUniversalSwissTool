import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lust/widgets/utils/menuDrawer.dart';

class AddTutorEntryPage extends StatefulWidget {
  static String title = "AddTutor...";
  static IconData icon = Icons.add_comment;

  static String tab;

  AddTutorEntryPage({tab = "Request"});

  @override
  _AddTutorEntryPageState createState() =>
      new _AddTutorEntryPageState(title, icon, tab);
}

class _AddTutorEntryPageState extends State<AddTutorEntryPage> {
  String dropdownValue;

  String title;
  IconData icon;

  String subject;
  String topic;
  String description;
  String userID = "TestUser"; // TODO get real userID

  Firestore db = Firestore.instance;

  _AddTutorEntryPageState(this.title, this.icon, this.dropdownValue);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    _height -= 85;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: MenuDrawer.getDrawer(context),
        body: ListView(
          itemExtent: _height,
          children: <Widget>[
            DropdownButton(
              value: dropdownValue,
              items: <String>['Request', 'Offer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: Key("subjectInput"),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: 'Subject', labelText: 'Subject'),
                      onSaved: (String value) {
                        this.subject = value;
                      },
                    ),
                    TextFormField(
                      key: Key("topicInput"),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: 'Topic', labelText: 'Topic'),
                      onSaved: (String value) {
                        this.topic = value;
                      },
                    ),
                    TextFormField(
                      key: Key("Description"),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: 'Description', labelText: 'Description'),
                      onSaved: (String value) {
                        this.description = value;
                      },
                    ),
                  ],
                )),
            RaisedButton(
                child: Text("Send"),
                onPressed: () {
                  _formKey.currentState.save();

                  CollectionReference collection;
                  if (dropdownValue == "Request") {
                    collection = db.collection('tutorRequest');
                  } else {
                    collection = db.collection('tutors');
                  }

                  var dataMap = new Map<String, dynamic>();
                  dataMap['description'] = description;
                  dataMap['topic'] = topic;
                  dataMap['userID'] = userID;
                  dataMap['subject'] = subject;
                  dataMap['timeStamp'] = DateTime.now();

                  collection.add(dataMap);

                  _formKey.currentState.dispose();
                }),
          ],
        ));
  } // build

}
