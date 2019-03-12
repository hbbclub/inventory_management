import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/agent/api.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/memo/memo_add_note_model.dart';
import 'package:inventory_management/bundles/memo/memo_add_note_page.dart';
import 'package:inventory_management/bundles/memo/memo_save_note.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

@ARoute(url: 'router://MemoPage')
class MemoPage extends StatefulWidget {
  final RouterPageOption initParam;
  MemoPage(this.initParam) : super();
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage>
    with AutomaticKeepAliveClientMixin {
  List<MemoAddNoteModel> list = [];
  @override
  void initState() {
    super.initState();
    requireNoteList();
  }

  requireNoteList() {
    api.noteList().then((result) {
      if (result.isError()) {
        return;
      }
      List labels = result.data['notes'] ?? [];
      List<MemoAddNoteModel> res = [];
      for (Map item in labels) {
        res.add(MemoAddNoteModel.fromJson(item));
      }
      print(res);
      if (this.mounted) {
        setState(() {
          this.list = res;
        });
      }
    });
  }

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
              child: Icon(
                Icons.search,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () async {
                // String barcode = await BarcodeScanner.scan();
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
              params: {
                'type': NotePageType.Add,
              },
            ),
          );
          Utils.pushScreen(context, page).then((result) {
            requireNoteList();
          });
        },
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var item = list[index];
          return ListTile(
            onTap: () {
              Widget page = MyRouter().findPage(
                RouterPageOption(
                  url: 'router://MemoAddNotePage',
                  params: {
                    'type': NotePageType.None,
                    'model': list[index],
                  },
                ),
              );
              Utils.pushScreen(context, page).then((result) {
                requireNoteList();
              });
              ;
            },
            title: Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('keyword:' + item.keyword),
                  Expanded(
                    child: Text(
                      'date:' +
                          (item.updatedAt != null
                              ? item.updatedAt.substring(0, 10)
                              : ''),
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            subtitle: Container(
              child: Text(item.notes ?? ''),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
