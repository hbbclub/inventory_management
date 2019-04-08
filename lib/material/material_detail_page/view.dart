import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/colors.dart';
import 'package:inventory_management/common/images.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MaterialDetailState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      titleSpacing: 0.0,
      title: Text('SKU Detail'),
    ),
    body: Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              (state.model.imgs != null
                  ? FadeInImage(
                      placeholder: AssetImage(ImageAssets.materalIcon),
                      image: NetworkImage(state.model.imgs.first.url),
                    )
                  : Image.asset(ImageAssets.materalIcon)),
              Positioned(
                bottom: 3,
                right: 16,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      // var image = await ImagePicker.pickImage(
                      //     source: ImageSource.gallery);
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 30,
            child: TabBar(
              indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
              isScrollable: true,
              indicatorColor: mainColor,
              //是否可以滚动
              controller: state.mTabController,
              labelColor: mainColor,
              unselectedLabelColor: Color(0XFFCCCCCC),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: choices.map((item) {
                return Tab(
                  text: item.title,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: state.mPageController,
              itemCount: choices.length,
              itemBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return viewService.buildComponent('info');
                    break;
                  case 1:
                    return viewService.buildComponent('stock');
                    break;
                  case 2:
                    return viewService.buildComponent('advanced');
                    break;
                  default:
                }
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    ),
  );
  
}
