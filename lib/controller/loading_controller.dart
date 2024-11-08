import 'package:get/get.dart';

class LoadingController extends GetxController {
  var loading = false.obs;

  setLoading(bool loading) {
    this.loading.value = loading;
  }
}