import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/state.dart';

class OcrListState implements Cloneable<OcrListState> {
  TextRecognizer textDetector = FirebaseVision.instance.textRecognizer();
  List<OcrLabelState> currentTextLabels = [];
  @override
  OcrListState clone() {
    return OcrListState()
      ..currentTextLabels = currentTextLabels
      ..textDetector = textDetector;
  }
}


OcrListState initState(Map<String, dynamic> args) {
  return OcrListState();
}
