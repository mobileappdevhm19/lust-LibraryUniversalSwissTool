import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBox {
  //TextBox(this._text);
  //final String _text;
  //String inputUser;
  static int _counter = 0;

  static int _getAndIncreaseCounter() {
    return _counter++;
  }

  static Widget getTextBox(
      BuildContext context, String _title, String _hint, IconData _icon) {
    String inputUser;
    Key key = new Key(_title + _getAndIncreaseCounter().toString());

    return new ListTile(
        leading: Icon(_icon, size: 35),
        title: TextFormField(
          decoration: InputDecoration(
            labelText: _title,
            //labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
            hintText: _hint,
            //hintStyle: TextStyle(fontSize: 13, color: Colors.black12),
          ),
//                        validator: (input) => input.length < 0
//                            ? "You have to write something!"
//                            : null,
          keyboardType: TextInputType.text,
          onSaved: (input) => inputUser = input,
        ));
  }
}
