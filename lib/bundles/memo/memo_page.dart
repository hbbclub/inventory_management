import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/common/images.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/memo/memo_add_note_page.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

class MemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Container(
          color: Colors.blue,
          padding: EdgeInsets.only(
            left: 20,
            top: 10,
            bottom: 10,
            right: 0,
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
             SizedBox(
              width: 65,
              child: MaterialButton(
                child: Image.asset(
                  ImageAssets.scan,
                
                ),
                onPressed: () async {
                  String barcode = await BarcodeScanner.scan();
                  
                },
              ),
            ),
          ],
       
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addNote',
        child: Icon(Icons.add),
        onPressed: () {
          Widget page = MyRouter().findPage(
            RouterPageOption(
              url: 'router://MemoAddNotePage',
              params: {'type': NotePageType.NotePageTypeAdd},
            ),
          );
          Utils.pushScreen(context, page);
        },
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Widget page = MyRouter().findPage(
                RouterPageOption(
                  url: 'router://MemoAddNotePage',
                  params: {'type': NotePageType.NotePageTypeNone},
                ),
              );
              Utils.pushScreen(context, page);
            },
            title: Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('keyword:xxx  '),
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
    
              child: Text(
                  'asdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsad'),
            ),
          ),
          ListTile(
            onTap: () {
              Widget page = MyRouter().findPage(
                RouterPageOption(
                  url: 'router://MemoAddNotePage',
                  params: {'type': NotePageType.NotePageTypeNone},
                ),
              );
              Utils.pushScreen(context, page);
            },
            title: Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('keyword:xxx  '),
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

              child: Text(
                  'asdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsadasdsadsadaadadsadsadsadsad'),
            ),
          )
        ],
      ),
    );
  }
}
