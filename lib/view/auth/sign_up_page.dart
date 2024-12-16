import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/sign_up_controller.dart';
import '../../res/app_function.dart';

import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../res/internet_utilis.dart';
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
  var signUpController = Get.find<SignUpController>();
  final formKeySignUp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        signUpController.clearFields();
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
                    SizedBox(
                      height: 50.h,
                    ),
                    const ProfileImageCaptureWidget(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(AppString.adminRegistration,
                        style: AppsTextStyle.largeTitleTextStyle),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(AppString.logInPageSubjectTitle,
                        style: AppsTextStyle.largeNormalText),
                    SizedBox(height: 20.h),
                    _buildSignUpForm(),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomAuthButtonWidget(
                      onPressed: () async {
                        if (!formKeySignUp.currentState!.validate()) return;
                        if (!(await NetworkUtili.verifyInternetStatus())) {
                          signUpController.createNewUserButton();
                        }
                      },
                      title: AppString.signup,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    RichTextWidget(
                        simpleText: AppString.alreadyCreateAccount,
                        colorText: AppString.signIn,
                        function: () async {
                          if (!(await NetworkUtili.verifyInternetStatus())) {
                            Get.back();
                            signUpController.clearFields();
                          }
                        }),
                    SizedBox(
                      height: .22.sh,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Form _buildSignUpForm() {
    return Form(
      key: formKeySignUp,
      child: Column(
        children: [
          TextFormFieldWidget(
            hintText: AppString.yourName,
            controller: signUpController.nameET,
            validator: (value) {
              if (value!.isEmpty) {
                return AppString.enterName;
              }
              return null;
            },
            textInputType: TextInputType.name,
          ),
          TextFormFieldWidget(
            hintText: AppString.emailAddress,
            controller: signUpController.emailET,
            validator: (value) {
              if (value!.isEmpty) {
                return AppString.enterEmailAddress;
              } else if (!AppsFunction.isValidEmail(value)) {
                return AppString.validEmailAddress;
              }
              return null;
            },
            textInputType: TextInputType.emailAddress,
          ),
          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return AppString.enterPassword;
              } else if (value.length < 6) {
                return AppString.validPassword;
              }
              return null;
            },
            hintText: AppString.password,
            controller: signUpController.passwordET,
          ),
          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return AppString.enterConfirmPassword;
              } else if (value.length < 6) {
                return AppString.validConfirmPassword;
              }
              return null;
            },
            hintText: AppString.passwordConfirm,
            controller: signUpController.confirmpasswordET,
          ),
          SizedBox(
            height: 10.h,
          ),
          IntlPhoneField(
            textInputAction: TextInputAction.done,
            controller: signUpController.phontET,
            style: AppsTextStyle.textFieldInputTextStyle(false),
            decoration: AppsFunction.textFormFielddecoration(
                hintText: AppString.phoneNumber, function: () {}),
            languageCode: "en",
            validator: (phoneNumber) {
              if (phoneNumber == null || phoneNumber.completeNumber.isEmpty) {
                return AppString.enterPhone;
              }
              if (phoneNumber.number.length < 10) {
                return AppString.validPhoneNumber;
              }
              return null;
            },
            initialCountryCode: 'BD',
            onChanged: (phoneNumber) {},
            onCountryChanged: (country) {},
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
