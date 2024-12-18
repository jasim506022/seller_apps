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
  // Initialize the SignUpController using GetX.
  var signUpController = Get.find<SignUpController>();

  // GlobalKey to validate the form.
  final formKeySignUp = GlobalKey<FormState>();

  // Utility function to add vertical spacing.
  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Handles back button behavior and clears fields on pop.
      onPopInvoked: (didPop) {
        signUpController.clearInputFields();
      },
      child: GestureDetector(
        // Unfocus keyboard when tapping outside text fields and check internet status.
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
                  verticalSpace(50),
                  const ProfileImageCaptureWidget(), // Widget to capture profile image.
                  verticalSpace(15),
                  Text(
                    AppString.adminRegistration, // Title text.
                    style: AppsTextStyle.largeTitleTextStyle,
                  ),
                  verticalSpace(10),
                  Text(
                    AppString.logInPageSubjectTitle, // Subtitle text.
                    style: AppsTextStyle.largeNormalText,
                  ),
                  verticalSpace(20),
                  _buildSignUpForm(), // Form containing input fields.
                  verticalSpace(15),
                  CustomAuthButtonWidget(
                    // Button to handle sign-up action.
                    onPressed: () async {
                      if (!formKeySignUp.currentState!.validate()) {
                        return;
                      }
                      if (!(await NetworkUtili.verifyInternetStatus())) {
                        // Check internet.
                        signUpController
                            .createNewUserButton(); // Call controller method.
                      }
                    },
                    title: AppString.signup, // Button text.
                  ),
                  verticalSpace(25),
                  RichTextWidget(
                    // Widget to navigate to sign-in page.
                    simpleText: AppString.alreadyCreateAccount,
                    colorText: AppString.signIn,
                    function: () async {
                      if (!(await NetworkUtili.verifyInternetStatus())) {
                        // Check internet.
                        Get.back(); // Navigate back.
                        signUpController.clearInputFields(); // Clear fields.
                      }
                    },
                  ),
                  SizedBox(height: .22.sh), // Additional spacing.
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
            hintText: AppString.yourName, // Placeholder text.
            controller: signUpController.nameET, // Controller for name input.
            validator: (value) =>
                _validateNonEmpty(value), // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),
          TextFormFieldWidget(
            hintText: AppString.emailAddress, // Placeholder text.
            controller: signUpController.emailET, // Controller for email input.
            validator: (value) => _validateEmail(value), // Validation method.
            textInputType: TextInputType.emailAddress, // Keyboard type.
          ),
          TextFormFieldWidget(
            obscureText: true, // Hide password input.
            isShowPassword: true, // Allow toggling visibility.
            validator: (value) =>
                _validatePassword(value), // Validation method.
            hintText: AppString.password, // Placeholder text.
            controller:
                signUpController.passwordET, // Controller for password input.
          ),
          TextFormFieldWidget(
            obscureText: true, // Hide password input.
            isShowPassword: true, // Allow toggling visibility.
            validator: (value) =>
                _validateConfirmPassword(value), // Validation method.
            hintText: AppString.passwordConfirm, // Placeholder text.
            controller: signUpController
                .confirmpasswordET, // Controller for confirm password input.
          ),
          SizedBox(height: 10.h), // Add spacing.
          IntlPhoneField(
            // Phone number input field with country code.
            textInputAction: TextInputAction.done, // Action on keyboard.
            controller: signUpController.phontET, // Controller for phone input.
            style: AppsTextStyle.textFieldInputTextStyle(false), // Text style.
            decoration: AppsFunction.textFormFielddecoration(
              hintText: AppString.phoneNumber, // Placeholder text.
              function: () {},
            ),
            languageCode: "en", // Language for country code picker.
            initialCountryCode: 'BD', // Default country code.
          ),
          SizedBox(height: 20.h), // Add spacing.
        ],
      ),
    );
  }

  // Validation for non-empty fields.
  String? _validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) return AppString.enterName;
    if (value.length < 6) return AppString.nameValid;
    return null;
  }

  // Validation for password field.
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppString.enterPassword;
    if (value.length < 6) return AppString.validPassword;
    return null;
  }

  // Validation for email field.
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.enterEmailAddress;
    } else if (!AppsFunction.isValidEmail(value)) {
      return AppString.validEmailAddress;
    }
    return null;
  }

  // Validation for confirm password field.
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return AppString.enterConfirmPassword;
    if (value != signUpController.passwordET.text) {
      return AppString.validConfirmPassword;
    }
    return null;
  }
}




/*
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var signUpController = Get.find<SignUpController>();
  final formKeySignUp = GlobalKey<FormState>();

  Widget verticalSpace(double height) => SizedBox(height: height.h);
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
                    verticalSpace(50),
                    const ProfileImageCaptureWidget(),
                    verticalSpace(15),
                    Text(AppString.adminRegistration,
                        style: AppsTextStyle.largeTitleTextStyle),
                    verticalSpace(10),
                    Text(AppString.logInPageSubjectTitle,
                        style: AppsTextStyle.largeNormalText),
                    verticalSpace(20),

                    _buildSignUpForm(),
                    verticalSpace(15),
                    CustomAuthButtonWidget(
                      onPressed: () async {
                        if (!formKeySignUp.currentState!.validate()) return;
                        if (!(await NetworkUtili.verifyInternetStatus())) {
                          signUpController.createNewUserButton();
                        }
                      },
                      title: AppString.signup,
                    ),
                    verticalSpace(25),
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

/*
              if (value!.isEmpty) {
                return AppString.enterName;
              }
              return null;
*/
  Form _buildSignUpForm() {
    return Form(
      key: formKeySignUp,
      child: Column(
        children: [
          TextFormFieldWidget(
            hintText: AppString.yourName,
            controller: signUpController.nameET,
            validator: (value) => _validateNonEmpty(value),
            textInputType: TextInputType.name,
          ),
          TextFormFieldWidget(
            hintText: AppString.emailAddress,
            controller: signUpController.emailET,
            validator: (value) => _validateEmail(value),
            textInputType: TextInputType.emailAddress,
          ),
          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: (value) => _validatePassword(value),
            hintText: AppString.password,
            controller: signUpController.passwordET,
          ),
          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: (value) => _validateConfirmPassword(value),
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
            initialCountryCode: 'BD',
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  //  // Utility Methods
  String? _validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) return AppString.enterName;
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppString.enterPassword;
    if (value.length < 6) return AppString.validPassword;
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.enterEmailAddress;
    } else if (!AppsFunction.isValidEmail(value)) {
      return AppString.validEmailAddress;
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return AppString.enterConfirmPassword;
    if (value != signUpController.passwordET.text) {
      return AppString.validConfirmPassword;
    }
    return null;
  }
}
*/