import 'package:flutter/material.dart';

class EmiPlansController with ChangeNotifier {
  var _emiTab = "";
  get emiTab => _emiTab;

  setEmiTab(value) {
    _emiTab = value;
    notifyListeners();
  }
}
