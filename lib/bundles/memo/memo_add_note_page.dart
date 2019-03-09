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

enum NotePageType {
  NotePageTypeNone,
  NotePageTypeAdd,
}

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
  static final TextRecognizer textDetector =
      FirebaseVision.instance.textRecognizer();
  List<Asset> images = List<Asset>();
  List<TextBlock> _currentTextLabels = <TextBlock>[];
  TextEditingController _textEditingController = TextEditingController();
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
              controller: _textEditingController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              maxLines: 3,
            ),
          ),
        ],
      ),
    ];
    widgets.addAll(
      List.generate(_currentTextLabels.length, (index) {
        return MemoAddNoteLabelTile(
            NoteLabel(_currentTextLabels[index].text, () {
          setState(() {
            _currentTextLabels.removeAt(index);
          });
        }));
      }),
    );

    widgets.addAll(
      List.generate(images.length, (index) {
        return ImageLabel(Key(index.toString()), index, images[index], (i) {
          setState(() {
            images.removeAt(i);
          });
        });
      }),
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.initParam.params['type'] == NotePageType.NotePageTypeAdd
              ? 'Add Note'
              : 'Note Detail',
        ),
        actions: widget.initParam.params['type'] == NotePageType.NotePageTypeAdd
            ? <Widget>[
                RawMaterialButton(
                  child: Icon(Icons.save),
                  onPressed: () {
                    Widget page = MyRouter().findPage(
                      RouterPageOption(
                        url: 'router://MemoSaveNotePage',
                        params: {
                          'files': images  ?? [],
                          'notes': _textEditingController.text,
                          'items': _currentTextLabels ?? [],
                        },
                      ),
                    );
                    Utils.pushScreen(context, page);
                  },
                ),
              ]
            : null,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: widgets,
        ),
      ),
      bottomNavigationBar:
          widget.initParam.params['type'] == NotePageType.NotePageTypeAdd
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('OCR'),
                        onPressed: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.camera);
                          if (image == null) {
                            return;
                          }
                          final FirebaseVisionImage visionImage =
                              FirebaseVisionImage.fromFile(image);
                          var visionText =
                              await textDetector.processImage(visionImage);
                          setState(() {
                            _currentTextLabels.clear();
                            _currentTextLabels.addAll(visionText.blocks);
                          });
                        },
                      ),
                      RaisedButton(
                          child: Icon(Icons.image),
                          onPressed: () {
                            loadAssets();
                          }),
                    ],
                  ),
                )
              : null,
    );
  }

  Future<void> loadAssets() async {
    // setState(() {
    //   images = List<Asset>();
    // });

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
      if (error == null) {
        print(error);
      }
    });
  }
}

class ImageLabel extends StatelessWidget {
  final int index;
  final Asset image;
  final Function onDelete;
  ImageLabel(Key key, this.index, this.image, this.onDelete) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Expanded(
            child: AssetView(key, index, image),
          ),
          IconButton(
            icon: Icon(
              Icons.cancel,
            ),
            onPressed: () => this.onDelete(index),
          )
        ],
      ),
    );
  }
}

class NoteLabel {
  // String title;
  String initValue;
  Function onDelete;
  NoteLabel(this.initValue, this.onDelete);
}

class MemoAddNoteLabelTile extends StatelessWidget {
  final NoteLabel label;
  MemoAddNoteLabelTile(this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              controller: TextEditingController(text: label.initValue),
            ),
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: label.onDelete,
          )
        ],
      ),
    );
  }
}
