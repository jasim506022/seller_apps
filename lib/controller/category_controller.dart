import 'package:get/get.dart';

import '../res/app_constants.dart';

class CategoryController extends GetxController {
  final _category = AppConstants.categoryList.first.obs;

  String get getCategory => _category.value;

  void setCategory({required String category}) {
    _category.value = category;
  }

  final _unit = AppConstants.unitList.first.obs;

  String get getUnit => _unit.value;

  void setUnit({required String unit}) {
    _unit.value = unit;
  }

  final _status = AppConstants.statusList.first.obs;
  String get getStatus => _status.value;

  void setStatus({required String status}) {
    _status.value = status;
  }
}
