import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/material/search_material.dart';

class MaterialInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('Material Info'),
        ),
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.search),
          onPressed: () {
            print('ok');
          },
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
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text('description'),
            title: Text('lorem ips'),
          ),
          ListTile(
            leading: Text('description description'),
            title: Text('lorem ips'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
          ListTile(
            title: Text('aaaa'),
          ),
        ],
      ),
    );
  }
}
