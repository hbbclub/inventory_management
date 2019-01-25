import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/material/search_material.dart';

class MaterialInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('Material Info'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.barcode),
            onPressed: () async {
              showSearch(
                context: context,
                delegate: SearchMaterial(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[

        ],
      ),
      floatingActionButton:IconButton(icon: Icon(Icons.search), onPressed: () {}, ),
    );
  }
}
