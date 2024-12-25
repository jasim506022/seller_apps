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
import 'widget/profile_capture_image_widget.dart';

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
        authController.clearInputFields();
      },
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
          NetworkUtili.verifyInternetStatus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppsFunction.verticalSpace(50),
                  const ProfileImageCaptureWidget(),
                  AppsFunction.verticalSpace(15),
                  Text(
                    AppString.adminRegistration,
                    style: AppsTextStyle.largeTitleTextStyle,
                  ),
                  AppsFunction.verticalSpace(10),
                  Text(
                    AppString.logInPageSubjectTitle,
                    style: AppsTextStyle.largeNormalText,
                  ),
                  AppsFunction.verticalSpace(20),
                  _buildSignUpForm(),
                  AppsFunction.verticalSpace(15),
                  CustomAuthButtonWidget(
                    onPressed: () async {
                      if (!formKeySignUp.currentState!.validate()) return;
                      await NetworkUtili.verifyInternetAndExecute(() async {
                        authController.registerUser();
                      });
                    },
                    title: AppString.signup,
                  ),
                  AppsFunction.verticalSpace(25),
                  RichTextWidget(
                    simpleText: AppString.alreadyCreateAccount,
                    colorText: AppString.signIn,
                    tap: () async {
                      Get.back();
                      authController.clearInputFields();
                    },
                  ),
                  SizedBox(height: .22.sh),
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
        children: [
          TextFormFieldWidget(
            hintText: AppString.yourName,
            controller: authController.nameController,
            validator: Validators.validateNonEmpty, // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),

          // Email
          TextFormFieldWidget(
            hintText: AppString.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          // Password
          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validatePassword,
            hintText: AppString.password,
            controller: authController.passwordController,
          ),

          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validateConfirmPassword,
            hintText: AppString.passwordConfirm,
            controller: authController.confirmPasswordController,
          ),
          AppsFunction.verticalSpace(10),

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
