import 'package:flutter/material.dart';

import '../../res/app_constants.dart';

class CateoryDropValueProvider with ChangeNotifier {
  String _cateoryDropValueProvider = AppConstants.allCategories.first;

  String get cateoryDropValue => _cateoryDropValueProvider;

  setDroupValue({required String selectValue}) {
    _cateoryDropValueProvider = selectValue;
    notifyListeners();
  }
}
