import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seller_apps/controller/forget_password_controller.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';

import '../../res/internet_utilis.dart';
import '../../widget/custom_auth_button_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_field_form_widget.dart';
import 'widget/app_sign_sign_page.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var forgetPasswordController = Get.find<ForgetPasswordController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        forgetPasswordController.cleanTextField();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Page Header
                AppSignInPageIntro(
                  title: "${AppString.forgetPassword}?",
                  description: AppString.entreEmailAddressForResetPassword,
                ),
                // Forget Password Form

                _buildForgetPasswordForm(),
                verticalSpace(10),
                // Reset Password Button
                CustomAuthButtonWidget(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;
                    if (!(await NetworkUtili.verifyInternetStatus())) {
                      forgetPasswordController.sendPasswordResetRequest();
                    }
                  },
                  title: AppString.resetPassword,
                ),
                verticalSpace(10),
                // Sign In Navigation
                RichTextWidget(
                  colorText: AppString.signIn,
                  function: () async {
                    Get.back();
                    forgetPasswordController.cleanTextField();
                  },
                  simpleText: AppString.youdontWantToReset,
                ),
                SizedBox(
                  height: 0.124.sh,
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
            hintText: AppString.emailAddress,
            controller: forgetPasswordController.emailET,
            validator: (emailText) {
              if (emailText!.isEmpty) {
                return AppString.enterEmailAddress;
              } else if (!AppsFunction.isValidEmail(emailText)) {
                return AppString.validEmailAddress;
              }
              return null;
            },
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
