import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/colors.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    MemoSaveState state, Dispatch dispatch, ViewService viewService) {
  final List<Widget> widgets = [
    SettingItem(
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Category',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
          hintText: 'Choose an Category',
          contentPadding: EdgeInsets.zero,
        ),
        isEmpty: state.activity == null,
        child: DropdownButton<String>(
          value: state.activity,
          onChanged: (String newValue) =>
              dispatch(MemoSaveActionCreator.selectCategory(newValue)),
          items:
              state.allActivities.map<DropdownMenuItem<String>>((String value) {
              
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })?.toList(),
        ),
      ),
    ),
    SettingItem(
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Keyword',
              hintText: 'Please enter keyword',
              labelStyle: TextStyle(fontSize: 16, color: Colors.black),
              hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
            ),
            controller: state.keywordController,
          )),
        ],
      ),
    ),
    SettingItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Send Mail'),
          Switch(
            activeColor: mainColor,
            onChanged: (bool value) =>
                dispatch(MemoSaveActionCreator.switchSendMail(value)),
            value: state.sendEmail,
          )
        ],
      ),
    ),
  ].map<Widget>((item) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Container(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0), child: item.child),
    );
  }).toList();
  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBar(
      title: Text(
        'Save Note',
      ),
      actions: <Widget>[
        RawMaterialButton(
          child: Text(
            'Done',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => dispatch(MemoSaveActionCreator.onSave()),
        ),
      ],
    ),
    body: Container(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonHideUnderline(child: ListView(children: widgets))),
  );
}
