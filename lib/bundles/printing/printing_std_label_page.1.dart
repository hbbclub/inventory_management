import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/agent/api.dart';
import 'package:inventory_management/bundles/common/colors.dart';
import 'package:inventory_management/bundles/common/images.dart';
import 'package:inventory_management/bundles/printing/printing_label_model.dart';

class PrintingStdLabelPage extends StatefulWidget {
  @override
  PrintingStdLabelPageState createState() {
    return new PrintingStdLabelPageState();
  }
}

class PrintingStdLabelPageState extends State<PrintingStdLabelPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<PrintingLabelModel> labels = [];
  @override
  void initState() {
    api.labelList().then((ApiModel result) {
      if (result.error != 0) {
        return;
      }
      //解析数据
      List labels = result.data['data'] ?? [];
      List<PrintingLabelModel> res = [];
      for (Map item in labels) {
        res.add(PrintingLabelModel.fromJson(item));
      }
      if (this.mounted) {
        setState(() {
          this.labels = res;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 44,
          child: FlatButton(
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.print,
                    size: 20,
                  ),
                  Text('Print Label')
                ],
              )),
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
              child: ListView.separated(
                itemCount: labels.length,
                itemBuilder: (BuildContext context, int index) {
                  return PrintingStdLabelTile(this.labels[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
              ),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class PrintingStdLabelTile extends StatelessWidget {
  final PrintingLabelModel model;
  final textController = TextEditingController(text: '0');
  PrintingStdLabelTile(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: FadeInImage(
              placeholder: AssetImage(
                ImageAssets.materalIcon,
              ),
              image: NetworkImage(model.imgs.first.url),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              style: TextStyle(color: Color(0XFF999999),fontSize: 16),
              controller: textController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              
                border: InputBorder.none,
                suffixIcon: Container(
                  color: Colors.white,
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (int.parse(textController.text) <= 0) {
                            return;
                          }
                          textController.text =
                              (int.parse(textController.text) - 1).toString();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          textController.text =
                              (int.parse(textController.text) + 1).toString();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
