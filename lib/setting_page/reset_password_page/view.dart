import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ResetPasswordState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Reset Password'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Old Password', labelText: 'Password'),
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'New Password', labelText: 'New Password'),
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'New Password', labelText: 'New Password'),
          ),
          Container(
            height: 20,
          ),
          RaisedButton(
            onPressed: () => dispatch(ResetPasswordActionCreator.onSave()),
            child: Text('Save'),
          )
        ],
      ),
    ),
  );
  ;
}
