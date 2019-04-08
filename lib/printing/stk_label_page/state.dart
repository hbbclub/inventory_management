import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class StkLabelState implements Cloneable<StkLabelState> {
  List<PrintingStkLabel> items;
  TextEditingController stockController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController lotNumberController = TextEditingController();
  TextEditingController printController = TextEditingController();

  TextEditingController countController = TextEditingController(text: '0');

  @override
  StkLabelState clone() {
    return StkLabelState()..items = items;
  }
}

StkLabelState initState(Map<String, dynamic> args) {
  StkLabelState state = StkLabelState();
  state.items = [
    PrintingStkLabel('Stock Code', '', state.stockController),
    PrintingStkLabel('Description', '', state.descController),
    PrintingStkLabel('UOM', '', state.uomController),
    PrintingStkLabel('QTY', '', state.qtyController),
    PrintingStkLabel('Lot Number', '', state.lotNumberController),
    PrintingStkLabel('Printer', '', state.printController),
  ];
  return state;
}

class PrintingStkLabel {
  String title;
  String initValue;
  TextEditingController controller;
  PrintingStkLabel(this.title, this.initValue, this.controller);
}
