import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/app_state.dart';
import 'package:inventory_management/welcome_page/page.dart';
import 'package:inventory_management/welcome_page/state.dart';

class AppRoute {
  AppRoutes<AppState> router;
  AppRoute._internal() {
    router = AppRoutes<AppState>(preloadedState: AppState(), pages: {
      // 这里有两种写法，效果是一样的，带操作符的写法比较生动，也简短些。
      routerNameForWelcomePage: WelcomeConnector() + WelcomePage(),
      // RoutePath.todoList: TodoListConn() + TodoListPage(),
      // RoutePath.todoDetail: TodoDetailConn() + TodoDetailPage(),
    });
  }
  //保存单例
  static AppRoute _singleton = AppRoute._internal();

  //工厂方法
  factory AppRoute() => _singleton;
}

final AppRoute appRouter = AppRoute();