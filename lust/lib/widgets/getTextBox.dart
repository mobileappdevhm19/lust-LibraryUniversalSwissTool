import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBox {
  //TextBox(this._text);
  //final String _text;
  //String inputUser;

  static Widget getTextBox(BuildContext context, String _title, String _hint) {
    String inputUser;

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          _title,
          style: TextStyle(fontSize: 20),
        ),
        TextField(
          decoration: InputDecoration(
            //labelText: "whatever",
            labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
            hintText: _hint,
            hintStyle: TextStyle(fontSize: 14, color: Colors.black12),
          ),
//                        validator: (input) => input.length < 0
//                            ? "You have to write something!"
//                            : null,
          keyboardType: TextInputType.text,
          onChanged: (input) => inputUser = input,
        ),
      ],
    );
  }
}
