
import 'package:flutter/material.dart';

class MaterialInfoTile extends StatelessWidget {
  final String title ;
  final String subtext ;
  MaterialInfoTile(this.title,this.subtext);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(title),
          ),
          Expanded(
            child: Text(subtext),
          )
        ],
      ),
    );
  }
}
