import 'package:annotation_route/route.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management/bundles/common/multi_image_picker/asset_view.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/memo/memo_add_note_model.dart';
import 'package:inventory_management/bundles/memo/memo_save_note.dart';
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
  static final TextRecognizer textDetector =
      FirebaseVision.instance.textRecognizer();
  List images = [];
  List<String> _currentTextLabels = [];
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    MemoAddNoteModel model = widget.initParam.params['model'];
    if (model != null) {
      print(model.toJson());
      _textEditingController.text = model.notes;
      if (model.items != null) {
        _currentTextLabels.addAll(List.generate(model.items.length, (index) {
          return model.items[index].value;
        }));
      }
      if (model.files != null) {
        images.addAll(List.generate(model.files.length, (index) {
          return model.files[index];
        }));
      }
    }
    super.initState();
  }

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
              textInputAction: TextInputAction.done,
              maxLines: 3,
            ),
          ),
        ],
      ),
    ];
    widgets.addAll(
      List.generate(_currentTextLabels.length, (index) {
        return MemoAddNoteLabelTile(NoteLabel(_currentTextLabels[index], () {
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
          widget.initParam.params['type'] == NotePageType.Add
              ? 'Add Note'
              : 'Note Detail',
        ),
        actions: <Widget>[
          RawMaterialButton(
            child: Icon(Icons.save),
            onPressed: () {
              Widget page = MyRouter().findPage(
                RouterPageOption(
                  url: 'router://MemoSaveNotePage',
                  params: {
                    'files': images ?? [],
                    'notes': _textEditingController.text,
                    'items': _currentTextLabels ?? [],
                    'type': widget.initParam.params['type'],
                    'id': widget.initParam.params['model']?.id,
                  },
                ),
              );
              Utils.pushScreen(context, page);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int index) {
            return widgets[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 8,
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              child: Text('OCR'),
              onPressed: () async {
                var image =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                if (image == null) {
                  return;
                }
                final FirebaseVisionImage visionImage =
                    FirebaseVisionImage.fromFile(image);
                var visionText = await textDetector.processImage(visionImage);
                setState(() {
                  _currentTextLabels.clear();
                  _currentTextLabels.addAll(visionText.blocks.map((block) {
                    return block.text;
                  }).toList());
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
      ),
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
      images.addAll(resultList);
      if (error == null) {
        print(error);
      }
    });
  }
}

class ImageLabel extends StatelessWidget {
  final int index;
  final Object image;
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
            child: this.image.runtimeType == NodeFile
                ? Image.network(Utils.hostUri + '/' + (image as NodeFile).url)
                : AssetView(key, index, image),
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
