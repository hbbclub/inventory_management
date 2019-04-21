import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StdLabelState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
      appBar: AppBar(
        title: Text('Label Print'),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 44,
        child: FlatButton(
            onPressed: () => dispatch(StdLabelActionCreator.onPrinterStd()),
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
      resizeToAvoidBottomPadding: false,
      body: InkWell(
        splashColor: Colors.white,
        onTap: () {
          FocusScope.of(viewService.context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            itemBuilder: adapter.itemBuilder,
            itemCount: adapter.itemCount,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 8.0,
              );
            },
          ),
        ),
      ));
}
