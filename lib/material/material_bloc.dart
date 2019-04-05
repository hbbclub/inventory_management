import 'package:inventory_management/bloc/bloc_provider.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/material/material_model.dart';
import 'package:rxdart/rxdart.dart';

class MaterialBloc extends BlocBase {
  MaterialBloc();
  MaterialModel resultModel = MaterialModel();
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();

//启动时调用
  Function(String) get handelSearchTextChanged => _searchSubject.sink.add;

  Stream<List<MaterialModel>> get suggestChangedStream => _searchSubject.stream
          .debounce(Duration(milliseconds: 1000))
          .asyncMap((text) {
        return api.materialList(keyword: text);
      }).map((ApiModel result) {
        if (result.error != 0) {
          return [];
        }
        List<MaterialModel> res = [];
        for (Map item in result.data['data']) {
          res.add(MaterialModel.fromJson(item));
        }
        return res;
      });

  @override
  void dispose() {
    _searchSubject.close();
  }
}
