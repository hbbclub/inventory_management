import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/agent/api.dart';
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
      List labels = result.data['labels'] ?? [];
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
        floatingActionButton: FloatingActionButton(
          heroTag: 'print',
          child: Icon(Icons.print),
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
  PrintingStdLabelTile(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 150,
            height: 75,
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
