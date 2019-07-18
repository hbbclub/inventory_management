import 'package:barcode_scan/barcode_scan.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:inventory_management/bloc/bloc_provider.dart';
import 'package:inventory_management/material/components/material_search_tile.dart';
import 'package:inventory_management/material/material_detail_page/page.dart';
import 'package:inventory_management/material/material_list_page/state.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'package:inventory_management/route/router.dart';

class SearchMaterial<T> extends SearchDelegate<String> {
  Context<MaterialListState> ctx;
  SearchMaterial(this.ctx);
  @override
  List<Widget> buildActions(BuildContext context) {
    MaterialBloc bloc = BlocProvider.of<MaterialBloc>(ctx.context);
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () async {
          try {
            String barcode = await BarcodeScanner.scan();
            query = barcode ?? '';
            bloc.handelSearchTextChanged(query);
          } catch (e) {
            print(e.toString());
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    MaterialBloc bloc = BlocProvider.of<MaterialBloc>(ctx.context);
    bloc.handelSearchTextChanged(query);

    return StreamBuilder(
      stream: bloc.source,
      builder:
          (BuildContext context, AsyncSnapshot<List<MaterialModel>> snapshot) {
        if (snapshot.hasData) {
          return Refresh(
            onFooterRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
            },
            // onHeaderRefresh: onHeaderRefresh,
            childBuilder: (BuildContext context,
                {ScrollController controller, ScrollPhysics physics}) {
              return new Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        appRouter.pushScreen(
                            ctx.context, routerNameForMaterialDetailPage,
                            arguments: snapshot.data[index]);
                      },
                      child: MaterialSearchTile(snapshot.data[index]),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: RefreshProgressIndicator(),
          );
        }
      },
    );
  }

  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {});
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MaterialBloc bloc = BlocProvider.of<MaterialBloc>(ctx.context);
    bloc.handelSearchTextChanged(query);
    return StreamBuilder(
      stream: bloc.source,
      builder:
          (BuildContext context, AsyncSnapshot<List<MaterialModel>> snapshot) {
        if (snapshot.hasData) {
          return Refresh(
            onFooterRefresh: ()=>bloc.handelLoadMore(query),
            // onHeaderRefresh: onHeaderRefresh,
            childBuilder: (BuildContext context,
                {ScrollController controller, ScrollPhysics physics}) {
              return new Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  physics: physics,
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        appRouter.pushScreen(
                            ctx.context, routerNameForMaterialDetailPage,
                            arguments: snapshot.data[index]);
                      },
                      child: MaterialSearchTile(snapshot.data[index]),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
