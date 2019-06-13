import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTutorEntryPage extends StatefulWidget {
  static String title = "AddTutor...";
  static IconData icon = Icons.add_comment;

  static String tab;

  AddTutorEntryPage({tab = "Request"});

  @override
  _AddTutorEntryPageState createState() =>
      new _AddTutorEntryPageState(title, icon);
}

class _AddTutorEntryPageState extends State<AddTutorEntryPage> {
  String dropdownValue = "Request";

  String title;
  IconData icon;

  BuildContext myContext;

  String subject;
  String topic;
  String description;
  String userID = "TestUser"; // TODO get real userID

  Firestore db = Firestore.instance;

  _AddTutorEntryPageState(this.title, this.icon);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    myContext = context;
    var _height = MediaQuery.of(context).size.height;
    _height -= 85;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
//        drawer: MenuDrawer.getDrawer(context),
        body: ListView(

          padding: EdgeInsets.all(10.0),

          children: <Widget>[
            DropdownButton(
              isExpanded: true,
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
                      autovalidate: false,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: 'Subject',
                          labelText: 'Subject (Only for test)'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a subject';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        this.subject = value;
                      },
                    ),
                    TextFormField(
                      key: Key("topicInput"),
                      autovalidate: false,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: 'Topic', labelText: 'Topic'),
                      autocorrect: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a topic';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        this.topic = value;
                      },
                    ),
                    TextFormField(
                      key: Key("description"),
                      autovalidate: false,
                      keyboardType: TextInputType.multiline,
                      decoration: new InputDecoration(
                          hintText: 'Description', labelText: 'Description'),
                      autocorrect: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a description';
                        }
                        return null;
                      },
                      maxLines: 20,
                      minLines: 5,
                      onSaved: (String value) {
                        this.description = value;
                      },
                    ),
                  ],
                )),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 50, minHeight: 40),
              child:
              RaisedButton(
                  padding: EdgeInsets.all(5),
                  child: Text("Submit"),
                  onPressed: () {
                    bool valid = _formKey.currentState.validate();

                    if (valid) {
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


                      Navigator.pop(context);
                    }
                  }), // RaisedButton
            ) // ConstrainedBox
          ],
        ));
  } // build

}
