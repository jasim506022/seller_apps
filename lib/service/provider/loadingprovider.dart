import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool _loading = false;

  bool get isLoading => _loading;

  setLoading({required bool loading}) {
    _loading = loading;
    notifyListeners();
  }
}
