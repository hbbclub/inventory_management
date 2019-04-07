import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management/common/images.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/common/utils.dart' show h,  sp;

import 'action.dart';
import 'state.dart';

Widget buildView(MainState state, Dispatch dispatch, ViewService viewService) {
  print(state.modules);
  return Scaffold(
      body: Stack(
    children: <Widget>[
      Image.asset(
        ImageAssets.mainBack,
        width: Utils.getScreenWidth(viewService.context),
        fit: BoxFit.fitWidth,
      ),
      Container(
        
        alignment: Alignment.topRight,
        height: 44,
        padding: EdgeInsets.only(top: h(ScreenUtil.statusBarHeight.toInt())),
        child: Center(
          child: Text(
            'HOME',
            style: TextStyle(color: Colors.white, fontSize: sp(36)),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(
            top: Utils.getScreenHeight(viewService.context) / 2.0),
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(8.0),
          mainAxisSpacing: 8.0, //竖向间距
          crossAxisCount: 2, //横向Item的个数
          crossAxisSpacing: 8.0, //横向间距
          childAspectRatio: 2 / 1,
          children: state.modules.map((module) {
            return Container(
               decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
              child: InkWell(
                onTap: ()=>dispatch(MainActionCreator.onEnterModule(module)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(module.iconPath,height: h(60),width: h(60),),
                    Text(module.title,style: TextStyle(
                      fontSize: sp(32),
                    ),)
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      )
    ],
  ));
}
