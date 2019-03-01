import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/material/material_bloc.dart';

class SearchMaterial<T> extends SearchDelegate<String> {
  MaterialBloc materialBloc;
  SearchMaterial(this.materialBloc);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            close(context, null);
          },
          title: Text('abbbbb'),
        );
      },
    );
  }
}
