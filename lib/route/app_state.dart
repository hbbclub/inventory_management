import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/scanner_page/state.dart';
import 'package:inventory_management/inventory_page/state.dart';
import 'package:inventory_management/login_page/state.dart';
import 'package:inventory_management/main_page/state.dart';
import 'package:inventory_management/material/material_detail_page/state.dart';
import 'package:inventory_management/material/material_list_page/state.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/state.dart';
import 'package:inventory_management/memo/memo_edit_page/state.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';
import 'package:inventory_management/memo/memo_list_page/state.dart';
import 'package:inventory_management/memo/memo_save_page/state.dart';
import 'package:inventory_management/tab_page/state.dart';
import 'package:inventory_management/welcome_page/state.dart';

class AppState implements Cloneable<AppState> {
  WelcomeState welcomeState = WelcomeState();
  LoginState loginState = LoginState();
  InventoryState inventoryState = InventoryState();
  ScannerState scannerState = ScannerState();
  MainState mainState = MainState();
  TabState tabState = TabState();
  MaterialListState materialListState = MaterialListState();
  MaterialDetailState materialDetailState = MaterialDetailState();
  MemoSaveState memoSaveState = MemoSaveState();
  MemoListState memoListState = MemoListState();
  MemoEditState memoEditState = MemoEditState();
  OcrListState ocrListState = OcrListState();

  @override
  AppState clone() {
    return AppState()
      ..welcomeState = welcomeState.clone()
      ..inventoryState = inventoryState.clone()
      ..loginState = loginState.clone()
      ..scannerState = scannerState.clone()
      ..mainState = mainState.clone()
      ..tabState = tabState.clone()
      ..materialListState = materialListState.clone()
      ..materialDetailState = materialDetailState.clone()
      ..memoSaveState = memoSaveState.clone()
      ..memoListState = memoListState.clone()
      ..ocrListState = ocrListState.clone()
      ..memoEditState = memoEditState.clone();
  }
}
