import 'package:flutter/material.dart';

class SearchTextProvider extends ChangeNotifier {
  String searchText = "";

  String get getSearchText => searchText;

  setDroupValue({required String selectValue}) {
    searchText = selectValue;
    notifyListeners();
  }
}
