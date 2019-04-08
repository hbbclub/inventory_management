import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/images.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(StdState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 200,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(1.0, 1.0),
              blurRadius: 5.0,
              spreadRadius: 1.0),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3.0))),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: FadeInImage(
            placeholder: AssetImage(
              ImageAssets.materalIcon,
            ),
            image: NetworkImage(state.imgs.first.url),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            style: TextStyle(color: Color(0XFF999999), fontSize: 16),
            controller: state.textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: Container(
                color: Colors.white,
                width: 100,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () => dispatch(StdActionCreator.subtract()),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () => dispatch(StdActionCreator.add()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
