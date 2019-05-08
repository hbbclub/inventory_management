import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/components/material_Info_tile.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    AdvancedState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return MaterialInfoTile(state.model.advInfo[index].label ?? '',
            state.model.advInfo[index].value ?? '');
      },
      itemCount: state.model.advInfo?.length ?? 0,
    ),
  );
}
