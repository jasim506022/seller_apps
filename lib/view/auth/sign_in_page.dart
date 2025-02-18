import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_asset/icon_asset.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';

import '../../res/network_utilis.dart';
import '../../res/routes/routes_name.dart';
import '../../res/validator.dart';
import '../../widget/custom_auth_button_widget.dart';

import '../../widget/rich_text_widget.dart';

import '../../widget/text_field_form_widget.dart';
import 'widget/app_sigin_in_page_intro_widget.dart';
import 'widget/social_button_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _setupStatusBar();
    super.didChangeDependencies();
  }

  void _setupStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundLight,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) async => await authController.exitApps(didPop),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSignInPageIntroWidget(
                    title: AppStrings.sellerLogIn,
                    description: AppStrings.logInPageSubjectTitle,
                  ),
                  _buildLoginForm(),
                  AppsFunction.verticalSpacing(5),
                  _buildForgetPasswordButton(),
                  AppsFunction.verticalSpacing(15),
                  CustomAuthButtonWidget(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await authController.signIn();
                      // await NetworkUtili.internetCheckingWFunction(
                      //     function: () async => await authController.signIn());
                    },
                    title: AppStrings.signIn,
                  ),
                  AppsFunction.verticalSpacing(25),
                  _buildOrDividerText(),
                  AppsFunction.verticalSpacing(20),
                  _buildSocialLoginOptions(),
                  AppsFunction.verticalSpacing(25),
                  RichTextWidget(
                    colorText: AppStrings.createAccount,
                    tap: () async => Get.toNamed(RoutesName.signupPage),
                    simpleText: AppStrings.dontHaveAccount,
                  ),
                  AppsFunction.verticalSpacing(100)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the social login options row (e.g., Facebook and Gmail).
  Row _buildSocialLoginOptions() {
    return Row(
      children: [
        Expanded(
          child: SocialButtonWidget(
            tap: () async =>
                NetworkUtils.executeWithInternetCheck(action: () {}),
            color: AppColors.blue,
            image: IconAsset.facebookIcon,
            title: AppStrings.facebook,
          ),
        ),
        AppsFunction.horizontalSpacing(10),
        Expanded(
          child: SocialButtonWidget(
            tap: () async => await NetworkUtils.executeWithInternetCheck(
                action: () async => await authController.signInWithGoogle()),
            color: AppColors.red,
            image: IconAsset.gmailIcon,
            title: AppStrings.gmail,
          ),
        ),
      ],
    );
  }

  /// Builds the "Forget Password" button aligned to the right.
  Align _buildForgetPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () async {
          NetworkUtils.executeWithInternetCheck(
              action: () => Get.toNamed(RoutesName.forgetPassword));
        },
        child: Text(
          AppStrings.forgetPassword,
          style: AppsTextStyle.mediumBoldText.copyWith(
            color: AppColors.hintLight,
          ),
        ),
      ),
    );
  }

  /// Builds the login form containing email and password input fields.
  Form _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: AppStrings.email,
            hintText: AppStrings.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),
          TextFormFieldWidget(
            label: AppStrings.password,
            isShowPassword: true,
            obscureText: true,
            validator: Validators.validatePassword,
            hintText: AppStrings.password,
            controller: authController.passwordController,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  /// Builds a divider with text in the center ("or").
  Row _buildOrDividerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLine(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            AppStrings.withOr,
            style:
                AppsTextStyle.largeNormalText.copyWith(color: AppColors.grey),
          ),
        ),
        _buildLine(),
      ],
    );
  }

  /// Builds a horizontal line for the divider.
  Container _buildLine() {
    return Container(
      height: 2.5.h,
      width: 70.w,
      color: AppColors.grey,
    );
  }
}
