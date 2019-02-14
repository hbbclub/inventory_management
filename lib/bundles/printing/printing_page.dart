import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/printing/printing_std_label_page.dart';
import 'package:inventory_management/bundles/printing/printing_stk_label_page.dart';

class PrintingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Printing'),
          bottom: new TabBar(
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return new Tab(
                text: choice.title,
                icon: new Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: [
            PrintingStdLabelPage(),
            PrintingStkLabelPage(),
          ],
        ),
      ),
      length: choices.length,
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'STD Label', icon: Icons.label),
  const Choice(title: 'Stk Code Label', icon: Icons.scanner),
];
