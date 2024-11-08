import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const/const.dart';
import '../const/gobalcolor.dart';
import '../const/textstyle.dart';
import '../service/provider/imageaddremoveprovider.dart';

class SelectPhotoProfile extends StatelessWidget {
  const SelectPhotoProfile(
      {super.key, required this.imagePicker, this.icChangeprofile});
  final ImagePicker imagePicker;
  final bool? icChangeprofile;
  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 10.w,
              height: 1.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).indicatorColor,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          SizedBox(height: 15.h),
          Align(
              alignment: Alignment.center,
              child: Text("Select Photo", style: textstyle.largeBoldText)),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              _showBottomModelItem(textstyle, "Camera", Icons.camera_alt, () {
                Navigator.pop(context);

                _captureImageSigle(
                    context: context,
                    imagePicker: imagePicker,
                    imageSource: ImageSource.camera);
              }),
              SizedBox(
                width: 30.w,
              ),
              _showBottomModelItem(textstyle, "Gallery", Icons.photo_album, () {
                Navigator.pop(context);

                _captureImageSigle(
                    context: context,
                    imagePicker: imagePicker,
                    imageSource: ImageSource.gallery);
              }),
            ],
          )
        ],
      ),
    );
  }

  _captureImageSigle(
      {required BuildContext context,
      required ImagePicker imagePicker,
      required ImageSource imageSource}) async {
    ImageAddRemoveProvider addUpdateProdcutProvider =
        Provider.of<ImageAddRemoveProvider>(context, listen: false);
    XFile? image = await imagePicker.pickImage(source: imageSource);
    addUpdateProdcutProvider.setSingleImageXFile(
        singleImageXFile: image, isChange: icChangeprofile ?? false);
  }

  Padding _showBottomModelItem(
      Textstyle textStyle, String title, IconData icon, VoidCallback funcion) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 8.w, vertical: 10.h),
      child: InkWell(
        onTap: funcion,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: greenColor)),
              child: Icon(
                icon,
                color: greenColor,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              title,
              style: textStyle.mediumText600.copyWith(color: greenColor),
            ),
          ],
        ),
      ),
    );
  }
}
