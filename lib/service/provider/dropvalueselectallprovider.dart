import 'package:flutter/material.dart';

import '../../const/global.dart';

class CateoryDropValueProvider with ChangeNotifier {
  String _cateoryDropValueProvider = allCategoryList.first;

  String get cateoryDropValue => _cateoryDropValueProvider;

  setDroupValue({required String selectValue}) {
    _cateoryDropValueProvider = selectValue;
    notifyListeners();
  }
}
