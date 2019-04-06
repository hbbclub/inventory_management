import 'package:flutter/material.dart';
import 'package:inventory_management/common/utils.dart';
// import 'package:inventory_management/printing/printing_std_label_page.dart';
import 'package:inventory_management/printing/printing_stk_label_page.dart';

class PrintingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: new TabBar(
            tabs: choices.map((Choice choice) {
              return Container(
                width: Utils.getScreenWidth(context) / 2.0,
                child: new Tab(
                  child: Text(
                    choice.title,
                    style: TextStyle(fontSize: 18),
                  ),

                  // icon: new Icon(choice.icon),
                ),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: [
            // PrintingStdLabelPage(),
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
  const Choice(
    title: 'STANDARD',
    icon: Icons.label,
  ),
  const Choice(title: 'STOCK CODE', icon: Icons.scanner),
];
