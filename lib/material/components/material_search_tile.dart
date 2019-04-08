import 'package:flutter/material.dart';
import 'package:inventory_management/common/images.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/material/model/material_model.dart';

class MaterialSearchTile extends StatelessWidget {
  final MaterialModel model;
  MaterialSearchTile(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: h(170),
        width: Utils.getScreenWidth(context),
        padding: EdgeInsets.symmetric(horizontal:  w(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: w(150),
              height: h(150),
              child: (model.imgs != null
                  ? FadeInImage(
                      placeholder: AssetImage(ImageAssets.materalIcon),
                      image: NetworkImage(model.imgs.first.url),
                      fit: BoxFit.fitHeight,
                    )
                  : Image.asset(ImageAssets.materalIcon)),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    model.partNo,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: sp(40)),
                  ),
                  Text(
                    model.desc,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: sp(32), color: Color(0xFF999999)),
                  ),
                  Text(
                    model.loc,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: sp(32), color: Color(0xFF999999)),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_right),
          ],
        ));
  }
}
