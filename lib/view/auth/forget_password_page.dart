import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';

import '../../res/validator.dart';
import 'widget/auth_button.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_field_form_widget.dart';
import 'widget/auth_intro_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final AuthController authController;
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //Get AuthController instance
    authController = Get.find<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => authController.resetFormIfNotLoading(), //
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Hide keyboard on tap,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthIntroWidget(
                    title: AppStrings.forgetPasswordTitle,
                    description: AppStrings.entreEmailAddressForResetPassword,
                  ),
                  _buildForgetPasswordForm(),
                  AppsFunction.verticalSpacing(10),
                  AuthButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      await authController.resetPassword();
                    },
                    label: AppStrings.resetPassword,
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

  Form _buildForgetPasswordForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: AppStrings.forgetPasswordTitle,
            hintText: AppStrings.passwordHint,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
