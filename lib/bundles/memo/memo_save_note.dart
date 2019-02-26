import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

@ARoute(url: 'router://MemoSaveNotePage')
class MemoSaveNotePage extends StatefulWidget {
  final RouterPageOption initParam;
  MemoSaveNotePage(this.initParam) : super();
  @override
  _MemoAddNotePageState createState() => _MemoAddNotePageState();
}

class SettingItem {
  Function onDone;
  Widget child;
  SettingItem({this.onDone, this.child});
}

class _MemoAddNotePageState extends State<MemoSaveNotePage> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  String _activity;
  bool _sendEmail = false;
  List<String> _allActivities = ['增加', '删除', '修改'];
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      SettingItem(
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Category',
            hintText: 'Choose an Category',
            contentPadding: EdgeInsets.zero,
          ),
          isEmpty: _activity == null,
          child: DropdownButton<String>(
            value: _activity,
            onChanged: (String newValue) {
              setState(() {
                _activity = newValue;
              });
            },
            items: _allActivities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
      SettingItem(
        child: Row(
          children: <Widget>[
            Text('Key Word'),
            Expanded(child: TextField()),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
              child: IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(
                  Icons.radio,
                ),
              ),
            )
          ],
        ),
      ),
      SettingItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Send eMail?'),
            Switch(
              onChanged: (bool value) {
                setState(() {
                  _sendEmail = value;
                });
              },
              value: _sendEmail,
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
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Save Note',
        ),
        actions: <Widget>[
          RawMaterialButton(
            child: Text(
              'done',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {},
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child:
              DropdownButtonHideUnderline(child: ListView(children: widgets))),
    );
  }
}
