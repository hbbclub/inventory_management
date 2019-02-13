
import 'package:flutter/cupertino.dart';

class MaterialInfoTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('123123'),
          ),
          Expanded(
            child: Text('123123'),
          )
        ],
      ),
    );
  }
}
