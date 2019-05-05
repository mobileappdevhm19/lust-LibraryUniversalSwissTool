import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBox {

  //TextBox(this._text);
  //final String _text;
  //String inputUser;

  static Widget getTextBox(BuildContext context, String _text) {
    String inputUser;

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          _text,
          style: TextStyle(),
        ),
        TextField(
          decoration: InputDecoration(
            //labelText: "Date?",
            labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
            //hintText: "DD/MM/YYYY",
            hintStyle: TextStyle(fontSize: 14, color: Colors.black12),
          ),
//                        validator: (input) => input.length < 0
//                            ? "You have to write something!"
//                            : null,
          keyboardType: TextInputType.datetime,
          onChanged: (input) => inputUser = input,
        ),
      ],
    );
  }
}
