import 'package:flutter/material.dart';

class PrintingStkLabel {
  String title;
  String initValue;
  PrintingStkLabel(this.title, this.initValue);
}

var items = <PrintingStkLabel>[
  PrintingStkLabel('Stock Code', ''),
  PrintingStkLabel('Description', ''),
  PrintingStkLabel('UOM', ''),
  PrintingStkLabel('QTY', ''),
  PrintingStkLabel('Lot Number', ''),
  PrintingStkLabel('Print To', ''),
  // PrintingStkLabel('# Of Labels', ''),
];

class PrintingStkLabelPage extends StatelessWidget {
  final TextEditingController textController = TextEditingController(text: '0');
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Container(
        child: Row(
          children: <Widget>[
            //  TextField(
            //   controller: TextEditingController(),
            //   decoration: InputDecoration(
            //     labelText: 'asdsda',
            //     hintText: 'Please enter ',
            //     labelStyle: TextStyle(fontSize: 20, color: Colors.black),
            //     hintStyle: TextStyle(fontSize: 20, color: Colors.red),
            //     border: InputBorder.none,
            //   ),
            // ),
          ],
        ),
      ),
    ];
    widgets.addAll(items.map((PrintingStkLabel item) {
      return PrintingStkTile(item);
    }).toList());

    widgets.addAll([
      Container(
        height: 60.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: '# Of Labels',
                  hintText: 'Please enter # of labels',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
                  border: InputBorder.none,
                  suffixIcon: Container(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            if (int.parse(textController.text) <= 0) {
                              return;
                            }
                            textController.text =
                                (int.parse(textController.text) - 1).toString();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            textController.text =
                                (int.parse(textController.text) + 1).toString();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 44,
        child: FlatButton(
            onPressed: () {},
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.print,
                  size: 20,
                ),
                Text('Print Label')
              ],
            )),
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
      // height: 60.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                labelText: this.label.title,
                hintText: 'Please enter ${this.label.title.toLowerCase()}',
                labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
