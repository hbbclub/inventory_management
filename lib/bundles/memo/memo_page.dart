import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/agent/api.dart';
import 'package:inventory_management/bundles/common/colors.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/memo/memo_add_note_model.dart';
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
      List labels = result.data['data'] ?? [];
      List<MemoAddNoteModel> res = [];
      for (Map item in labels) {
        res.add(MemoAddNoteModel.fromJson(item));
      }

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
        title: Text('MEMO'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
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
      body: Container(
        padding: EdgeInsets.only(bottom: 16),
        color: Color(0XFFEEEEEE),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 5, 5, 8),
              color: Colors.white,
              child: TextField(
                onSubmitted: (text) {
                },
                
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {},
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, i) {
                  return SizedBox(
                    height: 16,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  MemoAddNoteModel item = list[index];
                  return Dismissible(
                    background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        )),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return item.createUserId == Utils.user.username;
                    },
                    onDismissed: (direction) async {
                      list.removeAt(index);
                      await api.deleteNote(item.id);
                    },
                    key: Key(index.toString()),
                    child: NoteTile(
                      item,
                      () {
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
                      },
                    ),
                  );
                },
                itemCount: list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NoteTile extends StatelessWidget {
  final Function onTop;
  final MemoAddNoteModel model;
  NoteTile(this.model, this.onTop);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: this.onTop,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(1.0, 1.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          padding: EdgeInsets.all(16),
          height: 160,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.keyword,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Container(
                height: 28,
                alignment: Alignment.centerLeft,
                child: Text(
                  model.category ?? '',
                  style: TextStyle(fontSize: 14, color: Color(0XFFBBBBBB)),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.notes ?? '',
                    maxLines: 4,
                    style: TextStyle(fontSize: 16, color: Color(0XFF333333)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Divider(),
              Container(
                height: 30,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        model.createUserId ?? '',
                        style:
                            TextStyle(fontSize: 14, color: Color(0XFFBBBBBB)),
                      ),
                    ),
                    Text(
                      model.updatedAt.substring(0, 10) ?? '',
                      style: TextStyle(fontSize: 14, color: Color(0XFFBBBBBB)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
