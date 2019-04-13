import 'package:flutter/material.dart';
import 'package:inventory_management/bloc/bloc_provider.dart';
import 'package:inventory_management/common/colors.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/welcome_page/page.dart';

void main() async {
  runApp(
    BlocProvider(
      bloc: appBloc,
      child: AppProvider(
        child: MaterialApp(
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
          home: WelcomePage(null).buildPage(null),
        ),
      ),
    ),
  );
}
