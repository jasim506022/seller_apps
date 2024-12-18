import 'package:flutter/material.dart';

import '../../res/app_string.dart';
import '../../res/internet_utilis.dart';

import '../../widget/loading_widget.dart';
import '../../widget/text_field_form_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/profile_controller.dart';

import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import 'widget/row_text_title_widget.dart';
import 'widget/about_data_widget.dart';
import 'widget/profile_image_section_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileController = Get.find<ProfileController>();

  // Indicates whether the page is in edit mode.
  late bool isEditMode;

  // Form key for validating form inputs.
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    isEditMode = Get.arguments ?? false;
    profileController.getUserInformationSnapshot();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks.

    profileController.dispose();
    super.dispose();
  }

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          // Handle back navigation to ensure unsaved changes are addressed.

          profileController.handleBackNavigaion(didPop);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                isEditMode ? AppString.editProfile : AppString.about,
              ),
              actions: [
                if (isEditMode)
                  IconButton(
                      onPressed: () async {
                        if (!key.currentState!.validate()) return;
                        if (!(await NetworkUtili.verifyInternetStatus())) {
                          // profileController.updateProfile();
                          Get.dialog(
                              barrierDismissible: false,
                              const LoadingWidget(message: "Profile Update"));
                        }
                      },
                      icon: const Icon(
                        Icons.done,
                      ))
              ],
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileImageSectionWidget(
                        isEditMode: isEditMode,
                      ),
                      verticalSpace(50),
                      isEditMode ? _buildFormField() : const AboutDataWidget(),
                      verticalSpace(100),
                    ],
                  ),
                ))));
  }

  _buildFormField() {
    return Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowTextTitleWidget(icon: Icons.person, title: AppString.name),
            TextFormFieldWidget(
              onChanged: (value) => profileController.addChangeListener(),
              validator: (value) => _validateNonEmpty(value),
              controller: profileController.nameTEC,
              hintText: AppString.yourName,
            ),
            verticalSpace(15),
            RowTextTitleWidget(icon: Icons.phone, title: AppString.phone),
            verticalSpace(15),
            IntlPhoneField(
              // Phone number input field with country code.
              textInputAction: TextInputAction.done, // Action on keyboard.
              controller:
                  profileController.phoneTEC, // Controller for phone input.
              style:
                  AppsTextStyle.textFieldInputTextStyle(false), // Text style.
              decoration: AppsFunction.textFormFielddecoration(
                hintText: AppString.phoneNumber, // Placeholder text.
                function: () {},
              ),
              languageCode: "en", // Language for country code picker.
              initialCountryCode: 'BD', // Default country code.
            ),
            verticalSpace(15),
            RowTextTitleWidget(icon: Icons.email, title: AppString.email),
            TextFormFieldWidget(
              controller: profileController.emailTEC,
              enabled: false,
              hintText: AppString.enterEmailAddress,
            ),
            verticalSpace(15),
            RowTextTitleWidget(icon: Icons.place, title: AppString.address),
            TextFormFieldWidget(
              validator: (value) => _validateaddresEmpty(value),
              onChanged: (p0) => profileController.addChangeListener(),
              hintText: AppString.pleaseEnterAddress,
              controller: profileController.addressTEC,
            ),
          ],
        ));
  }

  // Validation for non-empty fields.
  String? _validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) return AppString.enterName;
    if (value.length < 6) return AppString.nameValid;
    return null;
  }

  String? _validateaddresEmpty(String? value) {
    if (value == null || value.isEmpty) return AppString.pleaseEnterAddress;

    return null;
  }
}

/*
  Widget _buildProfileImageSection() {
    return isEdit
        ? _editableProfileImage()
        : _profileImage(
            ClipOval(
              child: FancyShimmerImage(
                imageUrl: profileController.profileModel.value.imageurl ??
                    AppConstants.sharedPreference!
                        .getString(AppString.imageurlSharedPreference)!,
              ),
            ),
          );
  }

  Widget _editableProfileImage() {
    return Stack(
      children: [
        Obx(() {
          final image =
              profileController.selectImageController.selectPhoto.value;
          return _profileImage(image == null
              ? ClipOval(
                  child: FancyShimmerImage(
                  imageUrl: profileController.profileModel.value.imageurl ??
                      AppConstants.sharedPreference!
                          .getString(AppString.imageurlSharedPreference)!,
                ))
              : CircleAvatar(backgroundImage: FileImage(image)));
        }),
        Positioned(bottom: 5, right: 5, child: _selectImage()),
      ],
    );
  }

  Container _profileImage(Widget child) {
    return Container(
        height: 180.h,
        width: 180.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 2)),
        child: child);
  }

  Container _selectImage() {
    return Container(
      decoration:
          BoxDecoration(color: Colors.red.shade400, shape: BoxShape.circle),
      child: IconButton(
          onPressed: () {
            Get.bottomSheet(
                backgroundColor: AppColors.white,
                const ProfilePhotoOptionSheetWidget());
            profileController.isChange.value = true;
          },
          icon: Icon(
            Icons.camera_alt,
            color: AppColors.white,
            size: 30.h,
          )),
    );
  }

*/




/*
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
    var mq = MediaQuery.of(context).size;
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
    var mq = MediaQuery.of(context).size;
    // Utils Utils = Utils(context);
    Textstyle textStyle = Textstyle(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      // ignore: deprecated_member_use
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
                                              // showModalBottomSheet(
                                              //   context: context,
                                              //   builder: (context) {
                                              //     return SelectPhotoProfile(
                                              //       icChangeprofile: true,
                                              //       imagePicker: picker,
                                              //     );
                                              //   },
                                              // );
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
                                            color: Utils.profileTextColor,
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
                                                  color: Utils.profileTextColor,
                                                ),
                                              ),
                                            )
                                          : TextFormFieldWidget(
                                              validator: (p0) {
                                                return "Text is Not Empty";
                                              },
                                              controller: _phoneTEC,
                                              enabled:
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
    var mq = MediaQuery.of(context).size;
    // Utils Utils = Utils(context);
    Textstyle textStyle = Textstyle(context);
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Utils.profileTextColor,
            ),
            SizedBox(
              width: mq.width * .025,
            ),
            Text(title, style: textStyle.profileText())
          ],
        ),
        isEmail
            ? TextFormFieldWidget(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Doesn't Empty";
                  }
                  return null;
                },
                hintText: "",
                controller: controller,
                enabled: false,
              )
            : TextFormFieldWidget(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Doesn't Empty";
                  }
                  return null;
                },
                hintText: "",
                controller: controller,
                enabled: !widget.isEdit ? false : true,
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

*/