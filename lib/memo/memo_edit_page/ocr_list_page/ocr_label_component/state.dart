import 'package:fish_redux/fish_redux.dart';

class OcrLabelState implements Cloneable<OcrLabelState> {
  String text;
  String id;
  bool selected = false;
  OcrLabelState({this.id, this.text, this.selected = false});
  @override
  OcrLabelState clone() {
    return OcrLabelState()
      ..text = text
      ..id = id
      ..selected = selected;
  }
}

OcrLabelState initState(Map<String, dynamic> args) {
  return OcrLabelState();
}
