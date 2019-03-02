import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/bloc/bloc_provider.dart';
import 'package:inventory_management/bundles/material/material_model.dart';

class SearchMaterial<T> extends SearchDelegate<String> {
  MaterialBloc bloc;
  SearchMaterial(this.bloc);
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
    return StreamBuilder(
      stream: bloc.suggestChangedStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<MaterialModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  bloc.resultModel = snapshot.data[index];
                  close(context, null);
                },
                title: Text(snapshot.data[index].partNo),
              );
            },
          );
        } else {
          return Center(
            child: RefreshProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bloc.handelSearchTextChanged(query);
    return StreamBuilder(
      stream: bloc.suggestChangedStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<MaterialModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  bloc.resultModel = snapshot.data[index];
                  close(context, null);
                },
                title: Text(snapshot.data[index].partNo),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
