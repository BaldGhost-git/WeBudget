import 'package:flutter/material.dart';

class AmountText with ChangeNotifier {
  String _amount = "0";
  String get amount => _amount;

  void calculate() {
    //TODO: Calculate
    notifyListeners();
  }

  void add(String text) {
    if (_amount == "0") {
      _amount = text;
    } else {
      _amount = _amount + text;
    }
    notifyListeners();
  }

  void delete() {
    String temp = _amount.substring(0, _amount.length - 1);
    if (_amount.isEmpty || temp.isEmpty) {
      _amount = "0";
    } else {
      _amount = temp;
    }
    notifyListeners();
  }

  void zero() {
    _amount = "0";
    notifyListeners();
  }
}
