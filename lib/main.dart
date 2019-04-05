import 'package:flutter/material.dart';
import 'package:inventory_management/common/colors.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/home/welcome.dart';

void main() async {
  
  runApp(AppProvider(
    child: MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Inventory Management',
      theme: ThemeData(
        primaryColor: mainColor,
        textTheme: TextTheme(
          body1: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          body2: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      home: Welcome(),
    ),
  ));
}
