import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/common/images.dart';
import 'package:inventory_management/bundles/common/utils.dart';

class Main extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Main>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  // STOCK PRINTING  MEMO INVENTORY SETTING
  void initState() {
    super.initState();
  }

  Widget buildItem(context,iconPath,text,func) {
    return Container(
      height: Utils.getScreenHeight(context) / 8.0,
      color: Colors.white,
      decoration: BoxDecoration(
         border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(3.0),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                ImageAssets.mainBack,
                width: Utils.getScreenWidth(context),
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                top: Utils.getScreenHeight(context) / 2.0,
                width: Utils.getScreenWidth(context),
                height: Utils.getScreenHeight(context) / 2.0,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.all(10.0),
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  children: <Widget>[
                    // buildItem(context),
                    // buildItem(context),
                    // buildItem(context),
                    // buildItem(context),
                    // buildItem(context),
                    // buildItem(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
