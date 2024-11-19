import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_apps/res/app_string.dart';

import '../const/global.dart';
import 'category_controller.dart';

class ProductController extends GetxController {
  final categoryController = Get.find<CategoryController>();
  Stream<QuerySnapshot<Map<String, dynamic>>> allProductListSnapshots() {
    final firestore = FirebaseFirestore.instance;

    final sellerDoc = firestore
        .collection("seller")
        .doc(sharedPreference!.getString(AppString.uidSharedPreference)!);
    return categoryController.getCategory == "All"
        ? sellerDoc
            .collection("products")
            .orderBy("publishDate", descending: true)
            .snapshots()
        : sellerDoc
            .collection("products")
            .where("productcategory", isEqualTo: categoryController.getCategory)
            .orderBy("publishDate", descending: true)
            .snapshots();
  }
}
