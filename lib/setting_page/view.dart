import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/common/colors.dart';
import 'package:inventory_management/common/images.dart';
import 'package:inventory_management/common/utils.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SettingState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('SETTING'),
      elevation: 0,
    ),
    body: Container(
      color: mainColor,
      child: ListView(
        children: <Widget>[
          _buildTile(ImageAssets.setting1, 'Reset Password',
              () => dispatch(SettingActionCreator.onJumpToResetPassword())),
          _buildSeparator(),
          _buildTile(ImageAssets.setting2, 'Clean Cache',
              () => dispatch(SettingActionCreator.onClearCache())),
          _buildSeparator(),
          _buildTile(ImageAssets.setting3, 'Server Managerment', () {}),
          _buildSeparator(),
          _buildTile(ImageAssets.setting4, 'Sign Out',
              () => dispatch(SettingActionCreator.onSignOut())),
        ],
      ),
    ),
  );
}

Widget _buildSeparator() {
  return SizedBox(height: h(30));
}

Widget _buildTile(String image, String title, Function onTop) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(w(6)),
      color: Colors.white,
    ),
    margin: EdgeInsets.symmetric(horizontal: w(32)),
    child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(color: Color(0xFF333333)),
        ),
        leading: Image.asset(
          image,
          // height: h(40),
        ),
        trailing: Icon(Icons.arrow_right, color: Color(0xFF333333)),
        onTap: onTop),
  );
}
