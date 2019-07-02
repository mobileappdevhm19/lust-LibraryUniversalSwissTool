import 'package:flutter/cupertino.dart';
import 'package:lust/utils/autenthicationAPI.dart';

class AuthProvider extends InheritedWidget{
  AuthProvider({Key key, Widget child, this.auth, this.lockerNumber}) : super(key: key, child: child);
  final BaseAuth auth;
  final lockerNumber;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(AuthProvider) as AuthProvider);
  }
}

//WAY OF IMPLEMENTING IT: AuthProvider.of(context).auth