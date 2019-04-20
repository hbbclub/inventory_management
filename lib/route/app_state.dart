import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/scanner_page/state.dart';
import 'package:inventory_management/inventory_page/state.dart';
import 'package:inventory_management/login_page/state.dart';
import 'package:inventory_management/welcome_page/state.dart';

class AppState implements Cloneable<AppState> {
  WelcomeState welcomeState = WelcomeState();
  LoginState loginState = LoginState();
  InventoryState inventoryState = InventoryState();
  ScannerState scannerState = ScannerState();

  @override
  AppState clone() {
    return AppState()
    ..welcomeState = welcomeState.clone()
    ..inventoryState = inventoryState.clone()
    ..loginState = loginState.clone()
    ..scannerState = scannerState.clone()
    ;
  }
}
