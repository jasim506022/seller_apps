import 'package:get/get.dart';
import '../res/app_constants.dart';

class CategoryManagerController extends GetxController {
  // Private Observables
  final RxString selectedCategory = AppConstants.categories.first.obs;
  final RxString selectedAllCategory = AppConstants.allCategories.first.obs;
  final RxString selectedUnit = AppConstants.units.first.obs;
  final RxString selectedStatus = AppConstants.orderStatuses.first.obs;

  void updateCategory(String category) => selectedCategory(category);
  void updateAllCategory(String category) => selectedAllCategory(category);
  void updateUnit(String unit) => selectedUnit(unit);
  void updateStatus(String status) => selectedStatus(status);
}
