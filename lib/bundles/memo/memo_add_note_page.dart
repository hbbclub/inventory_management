import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_management/bundles/common/multi_image_picker/asset_view.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/route/route.route.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart';

@ARoute(url: 'router://MemoAddNotePage')
class MemoAddNotePage extends StatefulWidget {
  final RouterPageOption initParam;
  MemoAddNotePage(this.initParam) : super();
  @override
  _MemoAddNotePageState createState() => _MemoAddNotePageState();
}

class _MemoAddNotePageState extends State<MemoAddNotePage> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  List<Asset> images = List<Asset>();
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('note'),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              maxLines: 3,
            ),
          ),
        ],
      ),
    ];
    widgets.addAll(items.map((item) {
      return new MemoAddNoteLabelTile(item);
    }).toList());

    widgets.addAll(
      List.generate(images.length, (index) {
        return Container(
          height: 150.0,
          width: 150.0,
          child: AssetView(index, images[index]),
        );
      }),
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add Note',
        ),
        actions: <Widget>[
          RawMaterialButton(
            child: Text(
              'done',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Widget page = MyRouter().findPage(
                RouterPageOption(
                  url: 'router://MemoSaveNotePage',
                  params: {},
                ),
              );
              Utils.pushScreen(context, page);
            },
          ),
        ],
      ),
      body: ListView(
        children: widgets,
      ),
      floatingActionButton: Container(
        height: 100,
        width: 80,
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('OCR'),
              onPressed: () {},
            ),
            RaisedButton(
                child: Icon(Icons.image),
                onPressed: () {
                  scaffoldKey.currentState
                      .showBottomSheet((BuildContext context) {
                    return Container(
                      height: 200,
                      width: 300,
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            title: Text('相机'),
                            onTap: () async {},
                          ),
                          ListTile(
                              title: Text('相册'),
                              onTap: () {
                                loadAssets();
                                Navigator.of(context).pop();
                              }),
                          ListTile(
                            title: Text('取消'),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  });
                }),
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) ;
    });
  }
}

class NoteLabel {
  String title;
  String initValue;
  NoteLabel(this.title, this.initValue);
}

var items = <NoteLabel>[
  NoteLabel('UOM', '1111'),
  NoteLabel('QTY', '1111'),
  NoteLabel('Lot Number', '1111'),
  NoteLabel('Print to', '1111'),
  NoteLabel('# of labels', '1111'),
];

class MemoAddNoteLabelTile extends StatefulWidget {
  final NoteLabel label;
  MemoAddNoteLabelTile(this.label) : super();

  @override
  MemoAddNoteLabelTileState createState() {
    return new MemoAddNoteLabelTileState();
  }
}

class MemoAddNoteLabelTileState extends State<MemoAddNoteLabelTile> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(this.widget.label.title),
            width: 100.0,
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: widget.label.initValue),
            ),
          ),
          Checkbox(
            onChanged: (value) {
              setState(() {
                this.selected = value;
              });
            },
            value: selected,
          )
        ],
      ),
    );
  }
}
