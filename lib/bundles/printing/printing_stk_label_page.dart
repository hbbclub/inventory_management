import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrintingStkLabel {
  String title;
  String initValue;
  PrintingStkLabel(this.title, this.initValue);
}

var items = <PrintingStkLabel>[
  PrintingStkLabel('Description', ' '),
  PrintingStkLabel('UOM', ' '),
  PrintingStkLabel('QTY', ' '),
  PrintingStkLabel('Lot Number', ' '),
  PrintingStkLabel('Print to', ' '),
  PrintingStkLabel('# of labels', ' '),
];

class PrintingStkLabelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Text('stock code'),
              width: 100.0,
            ),
            Expanded(
              child: TextField(),
            ),
            Icon(FontAwesomeIcons.barcode),
          ],
        ),
      ),
    ];
    widgets.addAll(items.map((PrintingStkLabel item) {
      return new PrintingStkTile(item);
    }).toList());
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.barcode),
        onPressed: () {},
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: widgets,
        ),
      ),
    );
  }
}

class PrintingStkTile extends StatelessWidget {
  final PrintingStkLabel label;
  PrintingStkTile(this.label) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      child: Row(
        children: <Widget>[
          Container(
            child: Text(this.label.title),
            width: 100.0,
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: label.initValue),
            ),
          ),
        ],
      ),
    );
  }
}
