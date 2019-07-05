import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lust/pages/utils/authProvider.dart';

import 'package:lust/widgets/chatPage/messageTile.dart';

class ChatPage extends StatefulWidget {
  static String title = "Tutor Chat";
  static IconData icon = Icons.chat;

//  final BaseAuth auth;
  final String _userID;
  final String _topicID;

  ChatPage(this._userID, this._topicID);

/*
  ChatPage(this.auth, this._topicID) {
    _userID = auth.getUserID();
  }
*/

  @override
  _ChatPageState createState() =>
      new _ChatPageState(title, icon, _userID, _topicID);
}

class _ChatPageState extends State<ChatPage> {
  final String title;
  final icon;

  final String _userID;
  final String _topicID;

  final TextEditingController _textEditingController =
      new TextEditingController();

  bool _isComposingMessage = false;

  final messageReference = Firestore.instance.collection('messages');

  _ChatPageState(this.title, this.icon, this._userID, this._topicID);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Tutor Chat"),
          //leading: BackButton(),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: _buildChatList(),
              ),
              new Divider(height: 1.0),
              new Container(
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ));
  }

  Widget _buildChatList() {
    return StreamBuilder<QuerySnapshot>(
      stream: messageReference
          .where('idTopic', isEqualTo: _topicID)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) return new Text('Empty');
        return new ListView(
          reverse: true,
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new MessageTile(document['idFrom'], document['content'], _userID);
          }).toList(),
        );
      },
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: null,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposingMessage
                      ? () => _textMessageSubmitted(_textEditingController.text)
                      : null,
                ),
              ),
            ],
          ),
        ));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();
    setState(() {
      _isComposingMessage = false;
    });
    _sendMessage(messageText: text);
  }

  void _sendMessage({String messageText}) {
    messageReference.document().setData({
      'content': messageText,
      'idFrom': _userID,
      'idTopic': _topicID,
      'timestamp': DateTime.now()
    });
  }
}
