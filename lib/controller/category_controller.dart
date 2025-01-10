import 'package:get/get.dart';
import '../res/app_constants.dart';

class CategoryController extends GetxController {
  // Private Observables
  final RxString category = AppConstants.categoryList.first.obs;
  final RxString unit = AppConstants.unitList.first.obs;
  final RxString status = AppConstants.statusList.first.obs;

  // // Getters
  // String get category => category.value;
  // String get unit => _unit.value;
  // String get status => _status.value;

  // Setters
  void setCategory(String category) => this.category.value = category;
  void setUnit(String unit) => this.unit.value = unit;
  void setStatus(String status) => this.status.value = status;
}
