import 'package:inventory_management/bundles/bloc/bloc_provider.dart';

class AppBloc extends BlocBase {
  //私有构造方法
  AppBloc._internal();

  //保存单例
  static AppBloc _singleton = AppBloc._internal();

  //工厂方法
  factory AppBloc() => _singleton;

  @override
  void dispose() {}
}

final appBloc = AppBloc();
