import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/bloc/bloc_provider.dart';
import 'package:inventory_management/bundles/home/home.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory Management',
      home: BlocProvider(
        bloc: appBloc,
        child: Home(),
      ),
    ));
