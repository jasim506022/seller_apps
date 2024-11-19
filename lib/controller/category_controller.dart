import 'package:get/get.dart';

import '../const/global.dart';

class CategoryController extends GetxController {
  final _category = categoryList.first.obs;

  String get getCategory => _category.value;

  void setCategory({required String category}) {
    _category.value = category;
  }

  final _unit = unitList.first.obs;

  String get getUnit => _unit.value;

  void setUnit({required String unit}) {
    _unit.value = unit;
  }
}
