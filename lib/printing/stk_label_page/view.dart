import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StkLabelState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgets = [];
  widgets.addAll(state.items.map((PrintingStkLabel item) {
    return PrintingStkTile(item);
  }).toList());

  widgets.addAll([
    Container(
      height: 60.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: state.countController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Please enter # of labels',
                labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
                border: InputBorder.none,
                suffixIcon: Container(
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () =>
                            dispatch(StkLabelActionCreator.subtract()),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () => dispatch(StkLabelActionCreator.add()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ]);
  return Scaffold(
    appBar: AppBar(
      title: Text('Print SKU Label'),
    ),
    // resizeToAvoidBottomPadding: false,
    bottomNavigationBar: Container(
      color: Colors.white,
      height: 44,
      child: FlatButton(
          onPressed: () {},
          child: Column(
            children: <Widget>[
              Icon(
                Icons.print,
                size: 20,
              ),
              Text('Print Label')
            ],
          )),
    ),
    body: Container(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: widgets,
      ),
    ),
  );
}

class PrintingStkTile extends StatelessWidget {
  final PrintingStkLabel label;
  PrintingStkTile(this.label) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: label.controller,
              decoration: InputDecoration(
                labelText: this.label.title,
                hintText: 'Please enter ${this.label.title.toLowerCase()}',
                labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
