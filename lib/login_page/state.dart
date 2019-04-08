import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class LoginState implements Cloneable<LoginState> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  var scaffoldkey = new GlobalKey<ScaffoldState>();
  bool canDoLogin = true;
  TextEditingController account = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController hostUrl = TextEditingController();
  TextEditingController linkWord = TextEditingController();

  @override
  LoginState clone() {
    return LoginState()
      ..formKey = formKey
      ..account = account
      ..scaffoldkey = scaffoldkey
      ..password = password
      ..hostUrl = hostUrl
      ..linkWord = linkWord
      ..canDoLogin = canDoLogin;
  }
}

LoginState initState(Map<String, dynamic> args) {
  return LoginState()
    ..account = TextEditingController(text: args['account'])
    ..password = TextEditingController(text: args['password'])
    ..hostUrl = TextEditingController(text: args['hostUri'])
    ..linkWord = TextEditingController(text: args['linkWord'])
    ..canDoLogin = false;
}
