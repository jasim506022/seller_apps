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
import '../../widget/custom_text_form_field.dart';
import 'widget/auth_intro_widget.dart';
import 'widget/profile_image_picker_widget.dart';

/// `SignUpPage` is a user registration screen where users can enter their details
/// to create a new account.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  /// Controller for handling authentication-related logic
  late final AuthController authController;
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    /// Get the `AuthController` instance for managing authentication.
    authController = Get.find<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents Back when Loadng True
      onPopInvoked: (didPop) => authController.resetFormIfNotLoading(), //
      child: GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), // Dismiss keyboard when tapping outside.
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header with profile image picker and description
                  AuthIntroWidget(
                    customWidget: const ProfileImagePicker(),
                    title: AppStrings.sellerRegistration,
                    description: AppStrings.authPageDescription,
                  ),

                  /// Displays the form.
                  _buildForm(),

                  AppsFunction.verticalSpacing(15),

                  /// Registration Button.
                  AuthButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      await authController.registerNewUser();
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
                        authController.resetFields();
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
  Form _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name input field
          CustomTextFormField(
            label: AppStrings.nameLabel,
            hintText: AppStrings.nameHint,
            controller: authController.nameController,
            validator: Validators.validateName, // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),

          // Email input field
          CustomTextFormField(
            label: AppStrings.emailLabel,
            hintText: AppStrings.emailHint,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          // Password input field
          CustomTextFormField(
            label: AppStrings.passwordLabel,
            obscureText: true,
            hasPasswordToggle: true,
            validator: Validators.validatePassword,
            hintText: AppStrings.passwordHint,
            textInputAction: TextInputAction.next,
            controller: authController.passwordController,
          ),

          // Confirm password input field
          CustomTextFormField(
            label: AppStrings.passwordConfirmLabel,
            obscureText: true,
            hasPasswordToggle: true,
            validator: (value) => Validators.validateConfirmPassword(
                value, authController.passwordController.text),
            hintText: AppStrings.confirmPasswordHint,
            controller: authController.confirmPasswordController,
          ),
          AppsFunction.verticalSpacing(10),
          // Phone number input field
          PhoneNumberWidget(
            controller: authController.phoneController,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
