import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrintingStdLabelPage extends StatefulWidget {
  @override
  PrintingStdLabelPageState createState() {
    return new PrintingStdLabelPageState();
  }
}

class PrintingStdLabelPageState extends State<PrintingStdLabelPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.barcode),
          onPressed: () {},
        ),
        resizeToAvoidBottomPadding: false,
        body: InkWell(
          splashColor: Colors.white,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                PrintingStdLabelTile(),
                PrintingStdLabelTile(),
                PrintingStdLabelTile(),
              ],
            ),
          ),
        ));
  }
}

class PrintingStdLabelTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.scanner,
            size: 80.0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
