import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lust/pages/utils/authProvider.dart';

class MessageTile extends StatelessWidget {
  final DocumentSnapshot _document;
  final String _userID;

  MessageTile(this._document, this._userID);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                child: Text(
                  _document['idFrom'],
                  style: TextStyle(
                    color: Color(0xff203152),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                //color: Colors.green,
                margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0)),
          ],
          mainAxisAlignment:
              isOwnMessage() ? MainAxisAlignment.end : MainAxisAlignment.start,
        ),
        Row(
          children: <Widget>[
            Container(
              child: Text(
                _document['content'],
                style: TextStyle(color: Color(0xff203152)),
                textAlign: TextAlign
                    .left, //_document['idFrom'] == _userID ? TextAlign.right : TextAlign.left,
              ),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 250.0,
              decoration: BoxDecoration(
                  color: Color(0xffE8E8E8),
                  borderRadius: BorderRadius.circular(8.0)),
              margin: EdgeInsets.only(
                bottom: 5.0,
                left: _document['idFrom'] == _userID ? 50.0 : 0.0,
                right: _document['idFrom'] == _userID ? 0.0 : 50.0,
              ),
            ),
          ],
          mainAxisAlignment:
              isOwnMessage() ? MainAxisAlignment.end : MainAxisAlignment.start,
        ),
      ],
    );
  }

  bool isOwnMessage() {
    return _document['idFrom'] == _userID;
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Text(
        _document['content'],
        style: TextStyle(color: Color(0xff203152)),
        textAlign:
            TextAlign.left, //_document['idFrom'] == _userID ? TextAlign.right : TextAlign.left,
      ),
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      width: 20.0,
      decoration: BoxDecoration(color: Color(0xffE8E8E8), borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.only(
        bottom: 5.0,
        left: _document['idFrom'] == _userID ? 50.0 : 0.0,
        right: _document['idFrom'] == _userID ? 0.0 : 50.0,
      ),
    );
  }
}
  */
