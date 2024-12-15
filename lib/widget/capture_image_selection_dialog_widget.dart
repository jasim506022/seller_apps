import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/add_product_controller.dart';
import '../res/apps_color.dart';
import '../res/apps_text_style.dart';

class CaptureImageSelectionDialogWidget extends StatefulWidget {
  const CaptureImageSelectionDialogWidget({
    super.key,
  });

  @override
  State<CaptureImageSelectionDialogWidget> createState() =>
      _CaptureImageSelectionDialogWidgetState();
}

class _CaptureImageSelectionDialogWidgetState
    extends State<CaptureImageSelectionDialogWidget> {
  var addProductController = Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        "Selected Image",
        style: AppsTextStyle.titleTextStyle.copyWith(color: AppColors.green),
      ),
      children: [
        SimpleDialogOption(
          onPressed: () {
            addProductController.uploadProductImage(ImageSource.camera);
            Get.back();
          },
          child: Text("Capture image with Camera",
              style: AppsTextStyle.mediumBoldText),
        ),
        SimpleDialogOption(
          onPressed: () {
            addProductController.uploadProductImage(ImageSource.gallery);
            Get.back();
          },
          child: Text("Capture image with Gallery",
              style: AppsTextStyle.mediumBoldText),
        ),
        SimpleDialogOption(
          onPressed: () {
            Get.back();
          },
          child: Text("Cancel",
              style:
                  AppsTextStyle.titleTextStyle.copyWith(color: AppColors.red)),
        ),
      ],
    );
  }

  // void captureImage(
  //     {required BuildContext context,
  //     required ImagePicker imagePicker,
  //     required ImageSource source}) async {
  //   ImageAddRemoveProvider provider =
  //       Provider.of<ImageAddRemoveProvider>(context, listen: false);
  //   Navigator.pop(context);

  //   XFile? image;
  //   List<XFile> imagesListXfile = [];

  //   if (source == ImageSource.camera) {
  //     image = await imagePicker.pickImage(source: ImageSource.camera);
  //     if (image != null) {
  //       imagesListXfile.add(image);
  //       provider.setImageListXfile(imageListXfile: imagesListXfile);
  //     }
  //   } else if (source == ImageSource.gallery) {
  //     imagesListXfile = await imagePicker.pickMultiImage();
  //     provider.setImageListXfile(imageListXfile: imagesListXfile);
  //   }
  // }
}
