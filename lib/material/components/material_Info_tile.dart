import 'package:flutter/material.dart';

class MaterialInfoTile extends StatelessWidget {
  final String title;
  final String subtext;
  MaterialInfoTile(this.title, this.subtext);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 80.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              subtext,
              textAlign: TextAlign.left,
              style: TextStyle(color: Color(0XFF999999)),
            ),
          )
        ],
      ),
    );
  }
}
