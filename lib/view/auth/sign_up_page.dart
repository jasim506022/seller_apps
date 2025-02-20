import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';

import '../../res/app_string.dart';
import '../../res/validator.dart';
import 'widget/auth_button.dart';
import '../../widget/phone_number_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_field_form_widget.dart';
import 'widget/auth_intro_widget.dart';
import 'widget/profile_image_picker_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final AuthController authController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authController = Get.find<AuthController>();

    super.initState();
  }

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
                  AuthIntroWidget(
                    customWidget: const ProfileImagePickerWidget(),
                    title: AppStrings.adminRegistration,
                    description: AppStrings.loginPageDescription,
                  ),
                  _buildSignUpForm(),
                  AppsFunction.verticalSpacing(15),
                  AuthButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      authController.registerUser();
                    },
                    label: AppStrings.signUpTitle,
                  ),
                  AppsFunction.verticalSpacing(25),
                  RichTextWidget(
                    normalText: AppStrings.alreadyHaveAccount,
                    highlightedText: AppStrings.signInTitle,
                    onTap: () async {
                      if (!authController.loadingController.loading.value) {
                        Get.back();
                        authController.clearInputFields();
                      }
                    },
                  ),
                  AppsFunction.verticalSpacing(150)
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
            validator: Validators.validateName, // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),

          // Email
          TextFormFieldWidget(
            label: AppStrings.email,
            hintText: AppStrings.emailHint,
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
            validator: (value) => Validators.validateConfirmPassword(
                value, authController.passwordController.text),
            hintText: AppStrings.passwordConfirm,
            controller: authController.confirmPasswordController,
          ),
          AppsFunction.verticalSpacing(10),
          PhoneNumberWidget(
            controller: authController.phoneController,
            textInputAction: TextInputAction.done,
          ),

          AppsFunction.verticalSpacing(20),
        ],
      ),
    );
  }
}
