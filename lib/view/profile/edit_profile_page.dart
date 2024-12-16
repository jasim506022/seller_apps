import 'package:flutter/material.dart';

import 'package:seller_apps/res/app_string.dart';

import '../../res/app_constants.dart';
import '../../res/apps_color.dart';
import '../../res/internet_utilis.dart';
import '../../res/utils.dart';

import '../../widget/profile_photo_option_sheet_widget.dart';
import '../../widget/text_field_form_widget.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/profile_controller.dart';

import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileController = Get.find<ProfileController>();

  late bool isEdit;
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    isEdit = Get.arguments ?? false;
    profileController.getUserInformationSnapshot();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeUtils utils = ThemeUtils();
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          profileController.handleBackNavigaion(didPop);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                isEdit ? "Edit Profile" : "About",
              ),
              actions: [
                isEdit
                    ? IconButton(
                        onPressed: () async {
                          if (!key.currentState!.validate()) return;
                          if (!(await NetworkUtili.verifyInternetStatus())) {
                            profileController.updateUserData();
                          }
                        },
                        icon: Icon(Icons.done,
                            color: Theme.of(context).primaryColor))
                    : Container()
              ],
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileImageSection(),
                      SizedBox(
                        height: 50.h,
                      ),
                      isEdit ? _buildFormField(utils) : const AboutDataWidget(),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ))));
  }

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

  _buildFormField(ThemeUtils utils) {
    return Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RowTextTitleWidget(icon: Icons.person, title: "Name"),
            TextFormFieldWidget(
              onChanged: (value) => profileController.addChangeListener(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                if (value.length <= 2) {
                  return "Name must be longer than 2 characters";
                }
                return null;
              },
              controller: profileController.nameTEC,
              hintText: 'Enter Your Name',
            ),
            SizedBox(
              height: 15.h,
            ),
            const RowTextTitleWidget(icon: Icons.phone, title: "Phone"),
            SizedBox(
              height: 15.h,
            ),
            IntlPhoneField(
              textInputAction: TextInputAction.next,
              controller: profileController.phoneTEC,
              style: AppsTextStyle.textFieldInputTextStyle(true),
              decoration: AppsFunction.textFormFielddecoration(
                  hintText: "Phone Number", function: () {}),
              languageCode: "en",
              initialCountryCode: 'BD',
              onChanged: (value) => profileController.addChangeListener(),
              onCountryChanged: (country) {},
            ),
            SizedBox(
              height: 15.h,
            ),
            const RowTextTitleWidget(icon: Icons.email, title: "Email"),
            TextFormFieldWidget(
              controller: profileController.emailTEC,
              enabled: false,
              hintText: 'eamil',
            ),
            SizedBox(
              height: 15.h,
            ),
            const RowTextTitleWidget(icon: Icons.place, title: "Address"),
            TextFormFieldWidget(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your Address";
                }
                return null;
              },
              onChanged: (p0) => profileController.addChangeListener(),
              hintText: "Enter Your Address",
              controller: profileController.addressTEC,
            ),
          ],
        ));
  }
}

class RowTextTitleWidget extends StatelessWidget {
  const RowTextTitleWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(title, style: AppsTextStyle.largeBoldText)
      ],
    );
  }
}

class AboutDataWidget extends StatelessWidget {
  const AboutDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Obx(() {
      var profileModel = profileController.profileModel.value;

      // Show loading indicator if any of the fields are null
      if ([
        profileModel.name,
        profileModel.phone,
        profileModel.email,
        profileModel.address
      ].contains(null)) {
        return const CircularProgressIndicator();
      }

      // Profile data to be displayed
      final profileData = [
        {
          'icon': Icons.person,
          'label': "Name",
          'value': profileModel.name,
        },
        {
          'icon': Icons.phone,
          'label': "Phone",
          'value': "0${profileModel.phone}",
        },
        {
          'icon': Icons.email,
          'label': "Email",
          'value': profileModel.email,
        },
        {
          'icon': Icons.place,
          'label': "Address",
          'value': profileModel.address,
        },
      ];

      return Column(
        children: profileData
            .map((item) => AboutDataItem(
                  item: item,
                ))
            .toList(),
      );
    });
  }
}

class AboutDataItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const AboutDataItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowTextTitleWidget(
          icon: item['icon'] as IconData,
          title: item['label'] as String,
        ),
        SizedBox(height: 10.h),
        Container(
          width: 1.sw,
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: ThemeUtils.textFieldColor, //utils.textFeildColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Text(
            item['value'] as String,
            style: AppsTextStyle.textFieldInputTextStyle(),
          ),
        ),
        SizedBox(height: 25.h),
      ],
    );
  }
}


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