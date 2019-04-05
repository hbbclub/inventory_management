import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/bloc/bloc_provider.dart';
import 'package:inventory_management/common/colors.dart';
import 'package:inventory_management/common/images.dart';

import 'package:inventory_management/material/info.dart';
import 'package:inventory_management/material/material_model.dart';
import 'package:inventory_management/material/search_material.dart';
import 'package:inventory_management/route/route.route.dart';

class MaterialInfoPage extends StatefulWidget {
  @override
  MaterialInfoPageState createState() {
    return new MaterialInfoPageState();
  }
}

class MaterialInfoPageState extends State<MaterialInfoPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TextEditingController controller;
  MaterialModel model = MaterialModel();
  String barcode = '';
  var currentPage = 0;
  var isPageCanChanged = true;
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
    controller = TextEditingController.fromValue(TextEditingValue.empty);
    mTabController = TabController(
      length: choices.length,
      vsync: this,
    );
    mTabController.addListener(() {
      //TabBar的监听
      if (mTabController.indexIsChanging) {
        //判断TabBar是否切换
        print(mTabController.index);
        onPageChange(mTabController.index, p: mPageController);
      }
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //判断是哪一个切换
      isPageCanChanged = false;
      await mPageController.animateToPage(index,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index); //切换Tabbar
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Container(
          color: mainColor,
          padding: EdgeInsets.only(
            left: 20,
            top: 10,
            bottom: 10,
            right: 0,
          ),
          child: Container(
            child: InkWell(
              onTap: () async {
                MaterialBloc bloc = BlocProvider.of<MaterialBloc>(context);
                await showSearch(
                  delegate: SearchMaterial(bloc),
                  context: context,
                );
                setState(() {
                  model = bloc.resultModel;
                });
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
              child: Image.asset(
                ImageAssets.scan,
              ),
              onPressed: () async {
                String barcode = await BarcodeScanner.scan();
                if (barcode != null) {
                  ApiModel result = await api.materialDetail(partNo: barcode);
                  if (result.error != 0) {
                    return [];
                  }
                  setState(() {
                    model = MaterialModel.fromJson(result.data);
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                (model.imgs != null
                    ? FadeInImage(
                        placeholder: AssetImage(ImageAssets.materalIcon),
                        image: NetworkImage(model.imgs.first.url),
                      )
                    : Image.asset(ImageAssets.materalIcon)),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        var image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 30,
              child: TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
                isScrollable: true,
                indicatorColor: mainColor,
                //是否可以滚动
                controller: mTabController,
                labelColor: mainColor,
                unselectedLabelColor: Color(0XFFCCCCCC),
                labelStyle: TextStyle(fontSize: 16.0),
                tabs: choices.map((item) {
                  return Tab(
                    text: item.title,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: mPageController,
                itemCount: choices.length,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Info(model);
                      break;
                    case 1:
                      return router.findPage(RouterPageOption(
                          url: 'router://AdvancedStockInfo',
                          params: {"model": model}));

                      break;
                    case 2:
                      return router.findPage(RouterPageOption(
                          url: 'router://AdvancedInfoPage',
                          params: {"model": model}));
                      break;
                    default:
                  }
                },
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: 'Info',
    icon: Icons.label,
  ),
  const Choice(title: 'Stocks', icon: Icons.scanner),
  const Choice(title: 'Advanced', icon: Icons.scanner),
];
