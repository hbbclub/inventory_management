import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/common/colors.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/memo/memo_add_categories_model.dart';
import 'package:inventory_management/memo/memo_add_note_model.dart';
import 'package:inventory_management/route/route.route.dart';
import 'package:multi_image_picker/asset.dart';

enum NotePageType {
  None,
  Add,
}

@ARoute(url: 'router://MemoSaveNotePage')
class MemoSaveNotePage extends StatefulWidget {
  final RouterPageOption initParam;
  MemoSaveNotePage(this.initParam) : super();
  @override
  _MemoAddNotePageState createState() => _MemoAddNotePageState();
}

class SettingItem {
  Function onDone;
  Widget child;
  SettingItem({this.onDone, this.child});
}

class _MemoAddNotePageState extends State<MemoSaveNotePage> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  String _activity;
  TextEditingController keywordController = TextEditingController();
  bool _sendEmail = false;

// Purchasing   采购
// Receiving  收货
// Warehouse  仓库
// QA  质量
// Engineer  工程师
// Production  生产
// Maintenance  维修
// Shipping   发货
// Traffic  运输
// Customer Service  客服

  List<String> _allActivities = [];
  MemoAddNoteModel model = MemoAddNoteModel();

  @override
  void initState() {
    super.initState();
    api.noteCategories().then((ApiModel result) {
      if (result.isError()) {
        return;
      }

      for (var item in result.data['data']) {
        _allActivities.add(CategoriesModel.fromJson(item).category);
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  void save() async {
    List images = widget.initParam.params['files'];
    List notes = widget.initParam.params['items'];
    model.id = widget.initParam.params['id'];
    model.notes = widget.initParam.params['notes'];
    model.keyword = keywordController.text;
    if (notes.length > 0) {
      model.items = List.generate(notes.length ?? 0, (index) {
        return NodeItem(
            item: 'note' + (index + 1).toString(), value: notes[index]);
      });
    }
    if (images.length > 0) {
      List<Asset> assets = images
          .where((image) {
            if (image.runtimeType == Asset) {
              return true;
            }
            return false;
          })
          .toList()
          .cast<Asset>();
      ApiModel result;
      List rowFiles = [];
      if (assets.length > 0) {
        result = await api.fileUpload(assets);
        if (result.isError()) {
          return;
        }
        rowFiles = result.data['data'] ?? [];
      }

      images.removeWhere((image) {
        if (image.runtimeType == Asset) {
          return true;
        }
        return false;
      });
      List uploadImages = [];

      uploadImages.addAll(rowFiles
          .map<NodeFile>((json) {
            return NodeFile.fromJson(json);
          })
          .toList()
          .cast<NodeFile>());
      uploadImages.addAll(images);
      this.model.files = uploadImages.cast<NodeFile>();
    }
    ApiModel addedResult;
    if (widget.initParam.params['type'] == NotePageType.Add) {
      addedResult = await api.addNote(model.toJson());
    } else {
      Map jsonMap = model.toJson();
      jsonMap['id'] = jsonMap['_id'];
      jsonMap.remove('_id');
      addedResult = await api.updateNote(jsonMap);
    }

    if (!addedResult.isError()) {
      Utils.popAll(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      SettingItem(
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Category',
            labelStyle: TextStyle(fontSize: 16, color: Colors.black),
            hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
            hintText: 'Choose an Category',
            contentPadding: EdgeInsets.zero,
          ),
          isEmpty: _activity == null,
          child: DropdownButton<String>(
            value: _activity,
            onChanged: (String newValue) {
              model.category = newValue;
              setState(() {
                _activity = newValue;
              });
            },
            items: _allActivities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
      SettingItem(
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Key Word',
                hintText: 'Pleast enter key word',
                labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                hintStyle: TextStyle(fontSize: 16, color: Color(0XFF999999)),
              ),
              controller: keywordController,
            )),
          ],
        ),
      ),
      SettingItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Send Mail'),
            Switch(
              activeColor: mainColor,
              onChanged: (bool value) {
                setState(() {
                  _sendEmail = value;
                  model.email = _sendEmail ? 1 : 0;
                });
              },
              value: _sendEmail,
            )
          ],
        ),
      ),
    ].map<Widget>((item) {
      return Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0), child: item.child),
      );
    }).toList();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Save Note',
        ),
        actions: <Widget>[
          RawMaterialButton(
            child: Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: save,
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child:
              DropdownButtonHideUnderline(child: ListView(children: widgets))),
    );
  }
}
