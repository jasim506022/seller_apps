import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const/gobalcolor.dart';
import '../service/provider/imageaddremoveprovider.dart';

class CaptureImageSelectionDialogWidget extends StatefulWidget {
  const CaptureImageSelectionDialogWidget(
      {super.key, required this.imagePicker});
  final ImagePicker imagePicker;

  @override
  State<CaptureImageSelectionDialogWidget> createState() =>
      _CaptureImageSelectionDialogWidgetState();
}

class _CaptureImageSelectionDialogWidgetState
    extends State<CaptureImageSelectionDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        "Selected Image",
        style: GoogleFonts.poppins(
          color: greenColor,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        SimpleDialogOption(
          onPressed: () {
            captureImage(
                context: context,
                imagePicker: widget.imagePicker,
                source: ImageSource.camera);
          },
          child: Text(
            "Capture image with Camera",
            style: GoogleFonts.poppins(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            captureImage(
                context: context,
                imagePicker: widget.imagePicker,
                source: ImageSource.gallery);
          },
          child: Text(
            "Capture image with Gallery",
            style: GoogleFonts.poppins(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: GoogleFonts.poppins(
              color: red,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  void captureImage(
      {required BuildContext context,
      required ImagePicker imagePicker,
      required ImageSource source}) async {
    ImageAddRemoveProvider provider =
        Provider.of<ImageAddRemoveProvider>(context, listen: false);
    Navigator.pop(context);

    XFile? image;
    List<XFile> imagesListXfile = [];

    if (source == ImageSource.camera) {
      image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imagesListXfile.add(image);
        provider.setImageListXfile(imageListXfile: imagesListXfile);
      }
    } else if (source == ImageSource.gallery) {
      imagesListXfile = await imagePicker.pickMultiImage();
      provider.setImageListXfile(imageListXfile: imagesListXfile);
    }
  }
}
