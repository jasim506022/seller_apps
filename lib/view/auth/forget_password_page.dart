import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';

import '../../res/validator.dart';
import 'widget/auth_button.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/custom_text_form_field.dart';
import 'widget/auth_intro_widget.dart';

/// This Page allows users to reset their password by entering their email.
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
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
      canPop: false,
      // Prevents Back when Loadng True
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
                  /// Displays an introduction (title & description).
                  AuthIntroWidget(
                    title: AppStrings.forgetPasswordTitle,
                    description: AppStrings.forgetPasswordDescription,
                  ),

                  /// Displays the form.
                  _buildForm(),
                  AppsFunction.verticalSpacing(10),

                  /// Reset Password Button.
                  AuthButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      await authController.resetPassword();
                    },
                    label: AppStrings.resetPasswordTitle,
                  ),
                  AppsFunction.verticalSpacing(20),
                  RichTextWidget(
                    highlightedText: AppStrings.signInTitle,
                    onTap: () async {
                      if (!authController.loadingController.loading.value) {
                        Get.back();
                        authController.resetFields();
                      }
                    },
                    normalText: AppStrings.youdontWantToReset,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Builds the password reset form**
  Form _buildForm() {
    return Form(
      key: formKey,
      child: CustomTextFormField(
        label: AppStrings.emailLabel,
        hintText: AppStrings.emailHint,
        controller: authController.emailController,
        validator: Validators.validateEmail,
        textInputType: TextInputType.emailAddress,
      ),
    );
  }
}
