import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/inventory/inventory_page.dart';
import 'package:inventory_management/bundles/material/material_info_page.dart';
import 'package:inventory_management/bundles/memo/memo_page.dart';
import 'package:inventory_management/bundles/printing/printing_page.dart';
import 'package:inventory_management/bundles/setting/setting_page.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  List<Widget> _widgets = [
    MaterialInfoPage(),
    PrintingPage(),
    MemoPage(),
    InventoryPage(),
    Setting(),
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gradient),
            title: Text('stock'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            title: Text('print'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            title: Text('memo'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adjust),
            title: Text('inventory'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('setting'),
          ),
        ],
      ),
    );
  }
}
