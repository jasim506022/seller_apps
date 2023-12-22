import 'package:flutter/material.dart';

import '../../model/productsmodel.dart';

class SearchProvider extends ChangeNotifier {
  bool _isSearch = false;

  bool get isSearch => _isSearch;

  setSearch({required bool isSearch}) {
    _isSearch = isSearch;
    notifyListeners();
  }

  final List<ProductModel> _searchList = [];

  List<ProductModel> get searchList => _searchList;

  addProductSearchList({required ProductModel productModel}) {
    _searchList.add(productModel);
    notifyListeners();
  }

  clearSearchList() {
    _searchList.clear();
    notifyListeners();
  }
}
