import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../const/utils.dart';
import '../../database/firebasedatabase.dart';
import '../../service/provider/editprofileprovider.dart';
import '../../widget/profiletextfieldwidget.dart';
import '../main/mainscreen.dart';
import '../../model/profilemodel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.isEdit});

  final bool isEdit;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _addressTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();

  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    _nameTEC.dispose();
    _addressTEC.dispose();
    _phoneTEC.dispose();
    _emailTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    Textstyle textStyle = Textstyle(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(onWillPop: () async {
        if (widget.isEdit) {
          bool? stayOnScreen = await globalMethod.stayOnScreenMethod(
              content: '"Do you Want to Save Profile Changes"',
              context: context,
              title: "Save Profile Data");
          return Future.value(stayOnScreen);
        }
        return true;
      }, child: Consumer<EditPageProvider>(
        builder: (context, editPageProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.isEdit ? "Edit Profile" : "Profile",
              ),
              actions: [
                widget.isEdit == true
                    ? IconButton(
                        onPressed: () async {
                          if (editPageProvider.isChangeProfilePicture) {
                            String fileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();

                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                // Creating a storage reference
                                Reference storageRef = FirebaseDatabase
                                    .storageRef
                                    .child("sellerImage")
                                    .child(FirebaseDatabase.selleruid)
                                    .child(fileName);

                                // Uploading the file
                                UploadTask uploadTask = storageRef.putFile(
                                    File(editPageProvider.imageXFile!.path));

                                // When the upload is complete
                                TaskSnapshot taskSnapshot =
                                    await uploadTask.whenComplete(() {});

                                // Getting the download URL
                                String downloadUrl =
                                    await taskSnapshot.ref.getDownloadURL();

                                // Setting the download URL in the provider
                                editPageProvider.setSinglePhotoUrl(
                                    imageUrl: downloadUrl);

                                // Creating profile data map
                                Map<String, dynamic> profileData = {
                                  "name": _nameTEC.text,
                                  "email": _emailTEC.text,
                                  "address": _addressTEC.text,
                                  "phone": _phoneTEC.text,
                                  "imageurl": editPageProvider.imageurl,
                                };

                                // Updating profile data
                                await FirebaseDatabase.updateProfileData(
                                    map: profileData);

                                // Displaying a success message
                                globalMethod.flutterToast(
                                    msg: "Successfully Update Profile Data");

                                // Navigating to the MainScreen
                                if (mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainScreen(),
                                    ),
                                  );
                                }
                              }
                            } on SocketException {
                              globalMethod.flutterToast(
                                  msg: "Please Check your Internet");
                            } catch (error) {
                              // Handling errors
                              print('Error: $error');
                              // Displaying an error message to the user, if necessary
                              globalMethod.flutterToast(
                                  msg: "Error updating profile data");
                            }
                          } else {
                            Map<String, dynamic> profileData = {
                              "name": _nameTEC.text,
                              "email": _emailTEC.text,
                              "address": _addressTEC.text,
                              "phone": _phoneTEC.text,
                            };

                            await FirebaseDatabase.updateProfileData(
                                    map: profileData)
                                .then((value) {
                              globalMethod.flutterToast(
                                  msg: "Successfully Update Profile Data");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ));
                            }).catchError((error) {
                              globalMethod.flutterToast(msg: "Error $error");
                            });
                          }
                        },
                        icon: Icon(Icons.done,
                            color: Theme.of(context).primaryColor))
                    : Container()
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: FirebaseDatabase.profileSnapshot(),
                  builder: (context, snapshot) {
                    try {
                      if (snapshot.hasData) {
                        ProfileModel profileModel =
                            ProfileModel.fromMap(snapshot.data!.data()!);
                        _nameTEC.text = profileModel.name!;
                        _emailTEC.text = profileModel.email!;
                        _addressTEC.text = profileModel.address!;
                        _phoneTEC.text = profileModel.phone!;
                        String image = profileModel.imageurl!;

                        return Column(
                          children: [
                            widget.isEdit == true
                                ? Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 3)),
                                        child:
                                            editPageProvider.imageXFile == null
                                                ? CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(image),
                                                  )
                                                : CircleAvatar(
                                                    backgroundImage: FileImage(
                                                        File(editPageProvider
                                                            .imageXFile!.path)),
                                                  ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red.shade400,
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              onPressed: () {
                                                // getImageFromGaller();
                                                // _selectImageForProfile(
                                                //     textStyle);
                                                globalMethod
                                                    .captureImageSinglePhoto(
                                                        context: context,
                                                        imagePicker: picker);
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: white,
                                                size: 30,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    width:
                                        MediaQuery.of(context).size.height * .2,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: red, width: 2)),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          editPageProvider.imageurl),
                                    ),
                                  ),
                            _buildTextForm(
                                controller: _nameTEC,
                                icon: Icons.person,
                                title: "Name"),
                            SizedBox(
                              height: mq.height * .012,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: utils.profileTextColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .025,
                                    ),
                                    Text("Phone",
                                        style: textStyle.profileText())
                                  ],
                                ),
                                SizedBox(
                                  height: mq.height * .012,
                                ),
                                widget.isEdit == false
                                    ? Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 58,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                width: 1),
                                            color:
                                                Theme.of(context).canvasColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          "+88${profileModel.phone!}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: utils.profileTextColor,
                                          ),
                                        ),
                                      )
                                    : ProfileTextFieldFormWidget(
                                        controller: _phoneTEC,
                                        enabled: widget.isEdit == false
                                            ? false
                                            : true,
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: mq.height * .011,
                            ),
                            _buildTextForm(
                                controller: _emailTEC,
                                icon: Icons.email,
                                title: "Email",
                                isEmail: true),
                            SizedBox(
                              height: mq.height * .011,
                            ),
                            _buildTextForm(
                                controller: _addressTEC,
                                icon: Icons.place,
                                title: "Address"),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return globalMethod.flutterToast(
                            msg: "Error: ${snapshot.error}");
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    } catch (error) {
                      return globalMethod.flutterToast(
                          msg: "Unexpected Error: $error");
                    }
                  },
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  Column _buildTextForm({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    bool isEmail = false,
  }) {
    Utils utils = Utils(context);
    Textstyle textStyle = Textstyle(context);
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: utils.profileTextColor,
            ),
            SizedBox(
              width: mq.width * .025,
            ),
            Text(title, style: textStyle.profileText())
          ],
        ),
        isEmail
            ? ProfileTextFieldFormWidget(
                controller: _nameTEC,
                enabled: true,
              )
            : ProfileTextFieldFormWidget(
                controller: _nameTEC,
                enabled: !widget.isEdit ? false : true,
              ),
      ],
    );
  }

  Future<dynamic> _selectImageForProfile(Textstyle textStyle) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) {
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
                  width: 100,
                  height: 4, // Adjust the height as needed
                  decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text("Profile Photo", style: textStyle.largeBoldText)),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  _showBottomModelItem(textStyle, "Camera", Icons.camera_alt,
                      () {
                    // getImageFromGaller();
                    // globalMethod.captureImageSinglePhoto(
                    //     context: context, imagePicker: picker);
                  }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .066,
                  ),
                  _showBottomModelItem(
                      textStyle, "Gallery", Icons.photo_album, () {}),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Padding _showBottomModelItem(
      Textstyle textStyle, String title, IconData icon, VoidCallback funcion) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
              height: MediaQuery.of(context).size.width * .01,
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
