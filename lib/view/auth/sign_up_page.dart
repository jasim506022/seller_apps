import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';

import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../res/internet_utilis.dart';
import '../../res/validator.dart';
import '../../widget/custom_auth_button_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_field_form_widget.dart';
import 'widget/profile_image_picker_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authController = Get.find<AuthController>();

  final formKeySignUp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                  AppsFunction.verticalSpace(50),
                  const ProfileImagePickerWidget(),
                  AppsFunction.verticalSpace(15),
                  Text(
                    AppString.adminRegistration,
                    style: AppsTextStyle.titleSignPageTextStyle,
                  ),
                  AppsFunction.verticalSpace(10),
                  Text(
                    AppString.logInPageSubjectTitle,
                    style: AppsTextStyle.descrptionTextStyle,
                  ),
                  AppsFunction.verticalSpace(20),
                  _buildSignUpForm(),
                  AppsFunction.verticalSpace(15),
                  CustomAuthButtonWidget(
                    onPressed: () async {
                      if (!formKeySignUp.currentState!.validate()) return;
                      await NetworkUtili.internetCheckingWFunction(
                          function: () async =>
                              await authController.registerUser());
                    },
                    title: AppString.signup,
                  ),
                  AppsFunction.verticalSpace(25),
                  RichTextWidget(
                    simpleText: AppString.alreadyCreateAccount,
                    colorText: AppString.signIn,
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
      key: formKeySignUp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWidget(
            label: AppString.name,
            hintText: AppString.yourName,
            controller: authController.nameController,
            validator: Validators.validateNonEmpty, // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),

          // Email
          TextFormFieldWidget(
            label: AppString.email,
            hintText: AppString.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          // Password
          TextFormFieldWidget(
            label: AppString.password,
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validatePassword,
            hintText: AppString.password,
            textInputAction: TextInputAction.next,
            controller: authController.passwordController,
          ),

          TextFormFieldWidget(
            label: AppString.passwordConfirm,
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validateConfirmPassword,
            hintText: AppString.passwordConfirm,
            controller: authController.confirmPasswordController,
          ),
          AppsFunction.verticalSpace(10),

          Text(AppString.phone, style: AppsTextStyle.labelTextStyle),
          AppsFunction.verticalSpace(8),
          IntlPhoneField(
            textInputAction: TextInputAction.done,
            controller: authController.phoneController,
            style: AppsTextStyle.textFieldInputTextStyle(false),
            decoration: AppsFunction.textFormFielddecoration(
              hintText: AppString.phoneNumber,
              function: () {},
            ),
            languageCode: "en",
            initialCountryCode: 'BD',
          ),
          AppsFunction.verticalSpace(20),
        ],
      ),
    );
  }
}
