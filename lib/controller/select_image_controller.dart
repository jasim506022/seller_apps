import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/app_exception.dart';
import '../repository/select_image_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_string.dart';
import '../view/auth/widget/error_dialog_widget.dart';

class SelectImageController extends GetxController {
  final SelectImageRepository repository;

  SelectImageController({required this.repository});
  var selectPhoto = Rx<File?>(null);

  void selectImage({required ImageSource imageSource}) async {
    try {
      var image = await repository.captureImageSingle(imageSource: imageSource);
      selectPhoto.value = image;
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppString.okay,
          ),
        );
      }
    }
  }
}
