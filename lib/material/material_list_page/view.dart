import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:inventory_management/material/components/material_search_tile.dart';
import 'package:inventory_management/route/router.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MaterialListState state, Dispatch dispatch, ViewService viewService) {
  print(state.list.length);
  return Scaffold(
    body: SafeArea(
      child: Container(
        color: Color(0XFFEEEEEE),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  state.type == MaterialListType.page ? 0 : 10, 5, 5, 8),
              color: Colors.white,
              child: TextField(
                controller: state.keywordController,
                onSubmitted: (text) =>
                    dispatch(MaterialListActionCreator.onSearch(text)),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 20,
                    ),
                    prefixIcon: state.type == MaterialListType.page
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () =>
                                dispatch(MaterialListActionCreator.onBack()),
                          )
                        : null,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () =>
                          dispatch(MaterialListActionCreator.onClearSearch()),
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Refresh(
                onFooterRefresh: () => dispatch(
                    MaterialListActionCreator.onLoadmore(state.list.length)),
                // onHeaderRefresh: onHeaderRefresh,
                childBuilder: (BuildContext context,
                    {ScrollController controller, ScrollPhysics physics}) {
                  return new Container(
                    color: Colors.white,
                    child: ListView.separated(
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                      physics: physics,
                      controller: controller,
                      itemCount: state.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => dispatch(
                              MaterialListActionCreator.onEnterDetail(
                                  state.list[index])),
                          child: MaterialSearchTile(state.list[index]),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
  ;
}
