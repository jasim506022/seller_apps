import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/gobalcolor.dart';

import '../../controller/sign_in_controller.dart';
import '../../res/app_asset/icon_asset.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';

import '../../res/routes/routes_name.dart';
import '../../widget/custom_button_widget.dart';

import '../../widget/rich_text_widget.dart';

import '../../widget/text_field_form_widget.dart';
import 'widget/app_sign_sign_page.dart';
import 'widget/icon_with_button_widget.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var signInController = Get.find<SignInController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: white, statusBarIconBrightness: Brightness.dark));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await AppsFunction.showBackDialog() ?? false;
        if (shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          AppsFunction.verifyInternetStatus();
        },
        child: Scaffold(
          backgroundColor: white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSignInPageIntro(
                    title: AppString.adminLogin,
                    subTitle: AppString.logInPageSubjectTitle,
                  ),
                  _buildLoginForm(),
                  SizedBox(
                    height: 5.h,
                  ),
                  _buildForgetPasswordButton(),
                  SizedBox(height: 15.h),
                  CustomButtonWidget(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      signInController.signInWithEmailAndPassword();
                    },
                    title: AppString.signIn,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  _buildOrDividerText(),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildSocialLoginOptions(),
                  SizedBox(
                    height: 25.h,
                  ),
                  RichTextWidget(
                    colorText: AppString.createAccount,
                    function: () async {
                      Get.toNamed(RoutesName.signupPage);
                    },
                    simpleText: AppString.dontHaveAccount,
                  ),
                  SizedBox(
                    height: .12.sh,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSocialLoginOptions() {
    return Row(
      children: [
        Expanded(
          child: IconWithButtonWidget(
              function: () async {
                AppsFunction.verifyInternetStatus();
              },
              color: AppColors.blue,
              image: IconAsset.facebookIcon,
              title: AppString.facebook),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: IconWithButtonWidget(
              function: () async {
                if (!(await AppsFunction.verifyInternetStatus())) {
                  await signInController.signWithGoogle();
                }
              },
              color: AppColors.red,
              image: IconAsset.gmailIcon,
              title: AppString.gmail),
        ),
      ],
    );
  }

  Align _buildForgetPasswordButton() {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () async {
            if (!(await AppsFunction.verifyInternetStatus())) {
              Get.toNamed(RoutesName.forgetPassword);
              signInController.cleanTextField();
            }
          },
          child: Text(AppString.forgetPassword,
              style: AppsTextStyle.mediumBoldText.copyWith(
                color: AppColors.hintLightColor,
              )),
        ));
  }

  Form _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            hintText: AppString.emailAddress,
            controller: signInController.emailET,
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
          TextFormFieldWidget(
            isShowPassword: true,
            obscureText: true,
            validator: (passwordText) {
              if (passwordText!.isEmpty) {
                return AppString.enterPassword;
              } else if (passwordText.length < 6) {
                return AppString.validPassword;
              }
              return null;
            },
            hintText: AppString.password,
            controller: signInController.passwordET,
          ),
        ],
      ),
    );
  }

  Row _buildOrDividerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLine(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            AppString.withOr,
            style: AppsTextStyle.mediumNormalTextStyle
                .copyWith(color: AppColors.grey),
          ),
        ),
        _buildLine(),
      ],
    );
  }

  Container _buildLine() {
    return Container(
      height: 2.5.h,
      width: 70.w,
      color: AppColors.grey,
    );
  }
}
