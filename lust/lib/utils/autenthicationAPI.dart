import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AutenthicationAPI {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}
//PENDING: check it without the 'abstract'
class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  @override
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }
}

class checkUser {
  //this formKey is absolutely essential to link the 'signIn/up' button w/the textBox
  //the FormState class contains the validate method. When the validate method is called, it will run the validator function for each text field in the form.
  final _formKey = new GlobalKey<FormState>();

  bool _validateKey(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }
  Future _checkUser() async{

  }
}