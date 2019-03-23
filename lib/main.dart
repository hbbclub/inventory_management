import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/common/colors.dart';
import 'package:inventory_management/bundles/home/home.dart';
import 'package:inventory_management/bundles/home/welcome.dart';

void main() async {
  runApp(MaterialApp(
    // debugShowCheckedModeBanner: false,
    title: 'Inventory Management',
    theme: ThemeData(
      
      primaryColor: mainColor,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: loginTextColor, width: 0.5)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5)),
        labelStyle: TextStyle(
          color: loginTextColor,
          fontSize: 40,
        ),
        contentPadding: EdgeInsets.all(10.0),
      ),
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
    home: Home(),
  ));
}
