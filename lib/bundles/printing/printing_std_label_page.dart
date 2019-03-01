import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/agent/api.dart';
import 'package:inventory_management/bundles/common/images.dart';

class PrintingStdLabelPage extends StatefulWidget {
  @override
  PrintingStdLabelPageState createState() {
    return new PrintingStdLabelPageState();
  }
}

class PrintingStdLabelPageState extends State<PrintingStdLabelPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    api.labelList().then((ApiModel data){
      if (data.error != 0) {
        return ;
      }
      //解析数据
      List datas = data.data['labels']??[];
      print(data);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.barcode),
          onPressed: () {},
        ),
        resizeToAvoidBottomPadding: false,
        body: InkWell(
          splashColor: Colors.white,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  PrintingStdLabelTile(ImageAssets.print1),
                  SizedBox(
                    height: 8,
                  ),
                  PrintingStdLabelTile(ImageAssets.print2),
                  SizedBox(
                    height: 8,
                  ),
                  PrintingStdLabelTile(ImageAssets.print3),
                ],
              ),
            ),
          ),
        ));
  }
}

class PrintingStdLabelTile extends StatelessWidget {
  final String iconPath;
  PrintingStdLabelTile(this.iconPath);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(iconPath),
          SizedBox(
            width: 8,
          ),
          Text('# of label'),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                controller: TextEditingController(),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
