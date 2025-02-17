import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';

import '../../res/app_string.dart';
import '../../res/network_utilis.dart';
import '../../res/validator.dart';
import '../../widget/custom_auth_button_widget.dart';
import '../../widget/phone_number_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_field_form_widget.dart';
import 'widget/app_sigin_in_page_intro_widget.dart';
import 'widget/profile_image_picker_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (!authController.loadingController.loading.value) {
          authController.clearInputFields();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSignInPageIntroWidget(
                    widget: const ProfileImagePickerWidget(),
                    title: AppStrings.adminRegistration,
                    description: AppStrings.logInPageSubjectTitle,
                  ),
                  _buildSignUpForm(),
                  AppsFunction.verticalSpace(15),
                  CustomAuthButtonWidget(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      await NetworkUtils.executeWithInternetCheck(
                          action: () async =>
                              await authController.registerUser());
                    },
                    title: AppStrings.signUp,
                  ),
                  AppsFunction.verticalSpace(25),
                  RichTextWidget(
                    simpleText: AppStrings.alreadyHaveAccount,
                    colorText: AppStrings.signIn,
                    tap: () async {
                      if (!authController.loadingController.loading.value) {
                        Get.back();
                        authController.clearInputFields();
                      }
                    },
                  ),
                  AppsFunction.verticalSpace(150)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build the sign-up form with various input fields and validations.
  Form _buildSignUpForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWidget(
            label: AppStrings.name,
            hintText: AppStrings.yourName,
            controller: authController.nameController,
            validator: Validators.validateNameEmpty, // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),

          // Email
          TextFormFieldWidget(
            label: AppStrings.email,
            hintText: AppStrings.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          // Password
          TextFormFieldWidget(
            label: AppStrings.password,
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validatePassword,
            hintText: AppStrings.password,
            textInputAction: TextInputAction.next,
            controller: authController.passwordController,
          ),

          TextFormFieldWidget(
            label: AppStrings.passwordConfirm,
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validateConfirmPassword,
            hintText: AppStrings.passwordConfirm,
            controller: authController.confirmPasswordController,
          ),
          AppsFunction.verticalSpace(10),
          PhoneNumberWidget(
            controller: authController.phoneController,
            textInputAction: TextInputAction.done,
          ),

          AppsFunction.verticalSpace(20),
        ],
      ),
    );
  }
}
