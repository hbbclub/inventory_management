import 'dart:math';

import 'package:annotation_route/route.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
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
  TextRecognizer textDetector = FirebaseVision.instance.textRecognizer();
  List<Asset> images = List<Asset>();
  List<VisionText> _currentTextLabels = <VisionText>[];
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
              onPressed: () async {
                var image =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                final FirebaseVisionImage visionImage =
                    FirebaseVisionImage.fromFile(image);
                var visionText = await textDetector.processImage(visionImage);
                print(123132);
                for (TextBlock block in visionText.blocks) {
                  final String text = block.text;
                  final List<RecognizedLanguage> languages =
                      block.recognizedLanguages;
                  print(text);
                  for (TextLine line in block.lines) {
                    // Same getters as TextBlock
                    for (TextElement element in line.elements) {
                      // Same getters as TextBlock
                    }
                  }
                }
              },
            ),
            RaisedButton(
                child: Icon(Icons.image),
                onPressed: () {
                  loadAssets();
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
        enableCamera: true,
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
