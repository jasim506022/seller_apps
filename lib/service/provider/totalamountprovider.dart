import 'package:flutter/material.dart';

class TotalAmountProvider extends ChangeNotifier {
  double _amount = 0.0;

  double get amount => _amount;

  setAmount({required double amount}) {
    _amount += amount;
    notifyListeners();
  }

  setZeroAmount() {
    _amount = 0.0;
    notifyListeners();
  }
}
