import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/select_image_repository.dart';
import '../res/app_function.dart';
import '../res/app_string.dart';

class SelectImageController extends GetxController {
  final SelectImageRepository repository;

  SelectImageController({required this.repository});
  var selectPhoto = Rx<File?>(null);

  void selectImage({required ImageSource imageSource}) async {
    try {
      var image = await repository.captureImageSingle(imageSource: imageSource);
      selectPhoto.value = image;
    } catch (e) {
      AppsFunction.flutterToast(msg: AppStrings.noImageSelectedToast);
    }
  }
}
