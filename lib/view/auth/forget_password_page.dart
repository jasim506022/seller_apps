import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';

import '../../res/network_utilis.dart';
import '../../res/validator.dart';
import '../../widget/custom_auth_button_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_field_form_widget.dart';
import 'widget/app_sigin_in_page_intro_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!authController.loadingController.loading.value) {
          authController.clearInputFields();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppSignInPageIntroWidget(
                  title: AppStrings.forgetPassword,
                  description: AppStrings.entreEmailAddressForResetPassword,
                ),
                _buildForgetPasswordForm(),
                AppsFunction.verticalSpacing(10),
                CustomAuthButtonWidget(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    await NetworkUtils.executeWithInternetCheck(
                        action: () async =>
                            await authController.resetPassword());
                  },
                  title: AppStrings.resetPassword,
                ),
                AppsFunction.verticalSpacing(20),
                RichTextWidget(
                  colorText: AppStrings.signIn,
                  tap: () async {
                    if (!authController.loadingController.loading.value) {
                      Get.back();
                      authController.clearInputFields();
                    }
                  },
                  simpleText: AppStrings.youdontWantToReset,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildForgetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: AppStrings.forgetPassword,
            hintText: AppStrings.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
