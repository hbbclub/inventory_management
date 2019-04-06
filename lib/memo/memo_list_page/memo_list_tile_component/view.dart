import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/utils.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MemoListTileState state, Dispatch dispatch, ViewService viewService) {
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
      return state.createUserId == Utils.user.username;
    },
    onDismissed: (direction) async {
      dispatch(MemoListTileActionCreator.onRemove(state.id));
    },
    key: Key(state.id),
    child: NoteTile(
      state,
      () {
        dispatch(MemoListTileActionCreator.onEdit(state));
      },
    ),
  );
}

class NoteTile extends StatelessWidget {
  final Function onTop;
  final MemoListTileState model;
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
