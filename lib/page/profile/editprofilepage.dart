import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../const/utils.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/imageaddremoveprovider.dart';
import '../../service/provider/loadingprovider.dart';
import '../../widget/custom_show_dialog_widget.dart';
import '../../widget/select_photo_profile_widget.dart';
import '../../widget/textfieldformwidget.dart';
import '../main/mainpage.dart';
import '../../model/profilemodel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage(
      {super.key, required this.isEdit, required this.profileModel});

  final bool isEdit;

  final ProfileModel profileModel;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _addressTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  String image = "";
  @override
  void initState() {
    final profileModel = widget.profileModel;
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<ImageAddRemoveProvider>(context, listen: false)
          ..setSingleImageXFile(singleImageXFile: null)
          ..setSingleImageUrl(singleImageUrl: "");
      },
    );
    _nameTEC.text = profileModel.name!;
    _emailTEC.text = profileModel.email!;
    _addressTEC.text = profileModel.address!;
    _phoneTEC.text = profileModel.phone!;
    image = profileModel.imageurl!;
    super.initState();
  }

  @override
  void dispose() {
    _nameTEC.dispose();
    _addressTEC.dispose();
    _phoneTEC.dispose();
    _emailTEC.dispose();
    super.dispose();
  }

  Future<void> handleProfileUpdate(
      ImageAddRemoveProvider imageAddRemoveProvider) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!_keyForm.currentState!.validate()) return;
        if (mounted) {
          Provider.of<LoadingProvider>(context, listen: false)
              .setLoading(loading: true);
        }

        Map<String, dynamic> profileData = {
          "name": _nameTEC.text,
          "email": _emailTEC.text,
          "address": _addressTEC.text,
          "phone": _phoneTEC.text,
        };

        if (imageAddRemoveProvider.isChangeProfilePicture) {
          await uploadProfilePictureAndData(
              imageAddRemoveProvider, profileData);
        } else {
          await updateProfileData(profileData);
        }
      }
    } on SocketException {
      globalMethod.flutterToast(msg: "Please Check your Internet");
    }
  }

  Widget _buildCircleAvatar(
      ImageAddRemoveProvider imageAddRemoveProvider, String image) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
      ),
      child: imageAddRemoveProvider.singleImageXFile == null
          ? CircleAvatar(backgroundImage: NetworkImage(image))
          : CircleAvatar(
              backgroundImage: FileImage(
                  File(imageAddRemoveProvider.singleImageXFile!.path)),
            ),
    );
  }

  Future<void> uploadProfilePictureAndData(
      ImageAddRemoveProvider imageAddRemoveProvider,
      Map<String, dynamic> profileData) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = FirebaseDatabase.storageRef
        .child("sellerImage")
        .child(FirebaseDatabase.selleruid)
        .child(fileName);

    UploadTask uploadTask =
        storageRef.putFile(File(imageAddRemoveProvider.singleImageXFile!.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadurl = await taskSnapshot.ref.getDownloadURL();
    profileData["imageurl"] = downloadurl;

    await updateProfileData(profileData);
  }

  Future<void> updateProfileData(Map<String, dynamic> profileData) async {
    await FirebaseDatabase.updateProfileData(map: profileData).then((_) {
      Provider.of<LoadingProvider>(context, listen: false)
          .setLoading(loading: false);
      globalMethod.flutterToast(msg: "Successfully Update Profile Data");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainPage()));
    }).catchError((error) {
      globalMethod.flutterToast(msg: "Error $error");
    });
  }

  Widget _buildNonEditableProfileImage(
      ImageAddRemoveProvider imageAddRemoveProvider) {
    return Container(
      height: mq.height * 0.2,
      width: mq.height * 0.2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: red, width: 2),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(
            backgroundColor: white,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: widget.profileModel.imageurl!,
          fit: BoxFit.cover,
        ),
      ),
    );
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
          return Future.value(stayOnScreenFunction(context));
        }
        return true;
      }, child: Consumer<ImageAddRemoveProvider>(
        builder: (context, imageAddRemoveProvider, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () async {
                    if (widget.isEdit) {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDialogWidget(
                            content: '"Do you Want to Save Profile Changes"',
                            title: "Save Profile Data",
                            isBackScreenButton: true,
                          );
                        },
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  )),
              title: Text(
                widget.isEdit ? "Edit Profile" : "Profile",
              ),
              actions: [
                if (widget.isEdit)
                  IconButton(
                    onPressed: () async {
                      await handleProfileUpdate(imageAddRemoveProvider);
                    },
                    icon: Icon(
                      Icons.done,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
              ],
            ),
            body: Consumer<LoadingProvider>(
              builder: (context, loadingProvider, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      loadingProvider.isLoading
                          ? LinearProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor)
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            widget.isEdit
                                ? Stack(
                                    children: [
                                      _buildCircleAvatar(
                                          imageAddRemoveProvider, image),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red.shade400,
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return SelectPhotoProfile(
                                                    icChangeprofile: true,
                                                    imagePicker: picker,
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(Icons.camera_alt,
                                                color: Colors.white, size: 30),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : _buildNonEditableProfileImage(
                                    imageAddRemoveProvider),
                            Form(
                              key: _keyForm,
                              child: Column(
                                children: [
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              height: 58,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .canvasColor,
                                                      width: 1),
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text(
                                                "+88${widget.profileModel.phone!}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: utils.profileTextColor,
                                                ),
                                              ),
                                            )
                                          : TextFieldFormWidget(
                                              validator: (p0) {
                                                return "Text is Not Empty";
                                              },
                                              controller: _phoneTEC,
                                              enable:
                                                  !widget.isEdit ? false : true,
                                              hintText: '',
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
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                );
              },
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
            ? TextFieldFormWidget(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Doesn't Empty";
                  }
                  return null;
                },
                hintText: "",
                controller: controller,
                enable: false,
              )
            : TextFieldFormWidget(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Doesn't Empty";
                  }
                  return null;
                },
                hintText: "",
                controller: controller,
                enable: !widget.isEdit ? false : true,
              )
      ],
    );
  }

  Future<bool> stayOnScreenFunction(BuildContext context) async {
    bool stayOnScreen = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialogWidget(
            content: '"Do you Want to Save Profile Changes"',
            title: "Save Profile Data");
      },
    );

    return stayOnScreen;
  }
}
