import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/material/search_material.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

class MemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Colors.blue,
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: Container(
            child: InkWell(
              onTap: () {
                // showSearch(
                //   delegate: SearchMaterial(),
                //   context: context,
                // );
              },
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.barcode),
            onPressed: () async {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Widget page = MyRouter().findPage(
            RouterPageOption(
              url: 'router://MemoAddNotePage',
              params: {},
            ),
          );
          Utils.pushScreen(context, page);
        },
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Note:1   keyword:xxx  '),
                  Expanded(
                    child: Text(
                      'date:1111-11-11',
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            subtitle: Container(
              padding: EdgeInsets.only(left: 60.0),
              child: Text(
                  'asdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsad'),
            ),
          ),
          ListTile(
            onTap: () {},
            title: Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Note:2   keyword:xxx  '),
                  Expanded(
                    child: Text(
                      'date:1111-11-11',
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            subtitle: Container(
              padding: EdgeInsets.only(left: 60.0),
              child: Text(
                  'asdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsad'),
            ),
          )
        ],
      ),
    );
  }
}
