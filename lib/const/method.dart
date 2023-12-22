import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/const/gobalcolor.dart';

import '../auth/signinscreen.dart';
import '../model/profilemodel.dart';
import '../service/provider/addupdateproductprovider.dart';
import '../service/provider/editprofileprovider.dart';
import 'global.dart';

class GlobalMethod {
  /*
    getUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;

    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection("seller")
          .doc(currentUser.uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          if (snapshot.data()!["status"] == "approved") {
            if (kDebugMode) {
              print("Bangladesh");
            }
            if (kDebugMode) {
              print(snapshot.data()!["status"] == "approved");
            }
            await sharedPreference!.setString("uid", snapshot.data()!["uid"]);
            await sharedPreference!
                .setString("email", snapshot.data()!["email"]);
            await sharedPreference!.setString("name", snapshot.data()!["name"]);
            await sharedPreference!
                .setString("imageurl", snapshot.data()!["imageurl"]!);
            await sharedPreference!
                .setString("phone", snapshot.data()!["phone"]!);
            isApproved = true;
          } else {
            isApproved = false;
          }
        }
      });
    }
    isApproved = false;
  }
  */

  getUser() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    try {
      await FirebaseFirestore.instance
          .collection("seller")
          .doc(currentUser.uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          ProfileModel profileModel = ProfileModel.fromMap(snapshot.data()!);
          if (profileModel.status == "approved") {
            await sharedPreference!.setString("uid", profileModel.uid!);
            await sharedPreference!.setString("email", profileModel.email!);
            await sharedPreference!.setString("name", profileModel.name!);
            await sharedPreference!
                .setString("imageurl", profileModel.imageurl!);
            await sharedPreference!.setString("phone", profileModel.phone!);
          } else {
            if (kDebugMode) {
              print("User Doesn't Exist");
            }
          }
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error:  $error");
      }
    }
  }

  double productPrice(double productprice, double discount) {
    return productprice - (productprice * discount / 100);
  }

  InputDecoration decorationDropDownButtonForm(BuildContext context) {
    return InputDecoration(
      fillColor: Theme.of(context).cardColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    );
  }

  String getFormateDate(
      {required BuildContext context, required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("yyyy-MM-dd").format(date);
  }

// Obtain Image From Dialog
  obtainImageDialog(
      {required BuildContext context, required ImagePicker imagePicker}) {
    return showDialog(
      context: context,
      builder: (context) {
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
                captureImageFromCamera(
                    context: context, imagePicker: imagePicker);
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
                captureImageFromGallery(
                    context: context, imagePicker: imagePicker);
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
      },
    );
  }

//Capture Image From Gallery
  captureImageFromGallery(
      {required BuildContext context, required ImagePicker imagePicker}) async {
    AddUpdadateProductProvider uploadSingleTourProvider =
        Provider.of<AddUpdadateProductProvider>(context, listen: false);
    Navigator.pop(context);
    List<XFile> imagesListXfile = await imagePicker.pickMultiImage();
    uploadSingleTourProvider.setImage(photo: imagesListXfile);
  }

//Capture Image From Gallery
  captureImageSinglePhoto(
      {required BuildContext context, required ImagePicker imagePicker}) async {
    EditPageProvider uploadSingleTourProvider =
        Provider.of<EditPageProvider>(context, listen: false);

    XFile? imagesListXfile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    uploadSingleTourProvider.setImageFile(photo: imagesListXfile!);
  }

//Capture Image From Camera
  captureImageFromCamera(
      {required BuildContext context, required ImagePicker imagePicker}) async {
    AddUpdadateProductProvider uploadSingleTourProvider =
        Provider.of<AddUpdadateProductProvider>(context, listen: false);
    Navigator.pop(context);
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    List<XFile> imagesListXfile = [];
    imagesListXfile.add(image!);
    uploadSingleTourProvider.setImage(photo: imagesListXfile);
  }

// Flutter Toast
  flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: greenColor,
        textColor: white,
        fontSize: 16.0);
  }

// StayOnScreenMethod
  Future<dynamic> stayOnScreenMethod(
      {required BuildContext context,
      required String title,
      required String content,
      bool isBackScreenButton = false}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(title,
              style: GoogleFonts.poppins(
                  color: greenColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          content: Text(content,
              style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay")),
            TextButton(
                onPressed: () {
                  if (isBackScreenButton) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context, true);
                  }
                },
                child: const Text("No"))
          ],
        );
      },
    );
  }

// Logout Screen
  logoutScreen({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(title,
              style: GoogleFonts.poppins(
                  color: greenColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          content: Text(content,
              style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700)),
          actions: [
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (c) => const SignInScrren()),
                    (route) => false,
                  );
                },
                child: const Text("Okay")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"))
          ],
        );
      },
    );
  }
}
