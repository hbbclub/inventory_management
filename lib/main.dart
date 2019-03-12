import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/login/login_page.dart';

void main() => runApp(MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Inventory Management',
      theme: ThemeData(
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
      home: LoginPage(),
    ));
