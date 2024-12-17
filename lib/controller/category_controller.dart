import 'package:get/get.dart';
import '../res/app_constants.dart';

class CategoryController extends GetxController {
  // Private Observables
  final RxString _category = AppConstants.categoryList.first.obs;
  final RxString _unit = AppConstants.unitList.first.obs;
  final RxString _status = AppConstants.statusList.first.obs;

  // Getters
  String get category => _category.value;
  String get unit => _unit.value;
  String get status => _status.value;

  // Setters
  void setCategory(String category) => _category.value = category;
  void setUnit(String unit) => _unit.value = unit;
  void setStatus(String status) => _status.value = status;
}
