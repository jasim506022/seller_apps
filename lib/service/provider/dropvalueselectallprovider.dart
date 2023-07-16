import 'package:flutter/material.dart';

import '../../const/global.dart';

class DropValuesAllProvider with ChangeNotifier {
  String droupSelectValue = categorylist.first;

  String get drouValue => droupSelectValue;

  setDroupValue({required String selectValue}) {
    droupSelectValue = selectValue;
    notifyListeners();
  }
}
