import 'package:flutter/material.dart';

import '../../model/profile_model.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/network_utilis.dart';

import '../../res/validator.dart';
import '../../widget/phone_number_widget.dart';
import '../../widget/custom_text_form_field.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';

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
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    isEditMode = Get.arguments ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (!profileController.loadingController.loading.value) {
            profileController.handleBackNavigaion(didPop);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                isEditMode ? AppStrings.editProfile : AppStrings.about,
              ),
              actions: [
                if (isEditMode)
                  IconButton(
                      onPressed: () async {
                        if (!key.currentState!.validate()) return;
                        NetworkUtils.executeWithInternetCheck(
                            action: () => profileController.updateProfile());
                      },
                      icon: const Icon(
                        Icons.done,
                      ))
              ],
            ),
            body: ListView(
              children: [
                Obx(() {
                  return profileController.loadingController.loading.value
                      ? const LinearProgressIndicator(
                          backgroundColor: AppColors.red,
                        )
                      : const SizedBox
                          .shrink(); // Use this to avoid rendering anything when not loading.
                }),
                FutureBuilder(
                  future: profileController.fetchUserProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text(AppStrings.noDataAvaiable));
                    }
                    if (snapshot.hasData) {
                      var profileModel =
                          ProfileModel.fromMap(snapshot.data!.data()!);
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 15.h),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProfileImageSectionWidget(
                                  isEditMode: isEditMode,
                                  imageUrl: profileModel.imageurl!,
                                ),
                                AppsFunction.verticalSpacing(50),
                                _buildFormField(profileModel),
                                AppsFunction.verticalSpacing(100),
                              ],
                            ),
                          ));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            )));
  }

  _buildFormField(ProfileModel profileModel) {
    return Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              label: AppStrings.nameLabel,
              onChanged: (value) =>
                  profileController.addChangeListener(profileModel),
              validator: Validators.validateName,
              controller: profileController.nameTEC,
              hintText: AppStrings.yourName,
              enabled: isEditMode,
            ),
            PhoneNumberWidget(
              enabled: isEditMode,
              controller: profileController.phoneTEC,
            ),
            CustomTextFormField(
              label: AppStrings.emailLabel,
              controller: profileController.emailTEC,
              enabled: false,
              hintText: AppStrings.emailHint,
            ),
            CustomTextFormField(
              label: AppStrings.address,
              validator: Validators.validatePassword,
              onChanged: (p0) =>
                  profileController.addChangeListener(profileModel),
              hintText: AppStrings.pleaseEnterAddress,
              controller: profileController.addressTEC,
              enabled: isEditMode,
            ),
          ],
        ));
  }
}





/*
class AboutSingleWidget extends StatelessWidget {
  const AboutSingleWidget({
    super.key,
    required this.title,
    required this.titleName,
  });

  final String title;
  final String titleName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppsTextStyle.labelTextStyle),
          AppsFunction.verticalSpace(8),
          Container(
            width: 1.sw,
            decoration: BoxDecoration(
                color: ThemeUtils.textFieldColor,
                borderRadius: BorderRadius.circular(15.r)),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Text(
              titleName,
              style: AppsTextStyle.textFieldInputTextStyle(false),
            ),
          )
        ],
      ),
    );
  }
}

class AboutDetails extends StatelessWidget {
  const AboutDetails({super.key, required this.profileModel});
  final ProfileModel profileModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutSingleWidget(
          title: AppString.name,
          titleName: profileModel.name!,
        ),
        AboutSingleWidget(
          title: AppString.phone,
          titleName: profileModel.phone!,
        ),
        AboutSingleWidget(
          title: AppString.email,
          titleName: profileModel.email!,
        ),
        AboutSingleWidget(
          title: AppString.address,
          titleName: profileModel.address!,
        ),
      ],
    );
  }
}

*/

/*

            /*
            Obx(() {
              if (profileController.loadingController.loading.value) {
                // Show loading indicator
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileImageSectionWidget(
                            isEditMode: isEditMode,
                          ),
                          AppsFunction.verticalSpace(50),
                          _buildFormField(),
                          AppsFunction.verticalSpace(100),
                        ],
                      ),
                    ));
              }
            })
            */
            
    */