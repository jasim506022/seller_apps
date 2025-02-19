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

import '../../widget/rich_text_widget.dart';

import '../../widget/text_field_form_widget.dart';
import 'widget/auth_intro_widget.dart';
import 'widget/auth_button.dart';
import 'widget/social_button.dart';

/// A sign-in page where users can log in with email/password or social accounts.
///
/// This page includes:
/// - A login form with validation.
/// - Social login buttons (Google, Facebook).
/// - A "Forget Password" option.
/// - A sign-up redirection link.
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final AuthController authController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authController = Get.find<AuthController>();
    _configureStatusBar();
    super.initState();
  }

  /// Configures the system UI to set the status bar color and icon brightness.
  void _configureStatusBar() {
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
      onPopInvoked:
          (didPop) async => // Prevents accidental app exit without confirmation.
              await authController.confirmExitApp(didPop),
      child: GestureDetector(
        // Dismiss keyboard when tapping outside.
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Displays an introduction (title & description).
                  const AuthIntroWidget(
                    title: AppStrings.sellerLogInTitle,
                    description: AppStrings.loginPageDescription,
                  ),
                  _buildLoginForm(),
                  AppsFunction.verticalSpacing(5),

                  /// "Forgot Password" button.
                  _buildForgetPasswordButton(),
                  AppsFunction.verticalSpacing(15),
                  AuthButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await authController.signIn();
                    },
                    label: AppStrings.signInTitle,
                  ),
                  AppsFunction.verticalSpacing(25),

                  /// OR divider section.
                  _buildOrDivider(),
                  AppsFunction.verticalSpacing(20),

                  /// Social login buttons (Google & Facebook)
                  _buildSocialLoginOptions(),
                  AppsFunction.verticalSpacing(25),

                  /// Sign-up link with navigation to the registration page.
                  RichTextWidget(
                    highlightedText: AppStrings.createAccount,
                    onTap: () => Get.toNamed(RoutesName.signupPage),
                    normalText: AppStrings.dontHaveAccount,
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

  /// Builds the login form containing email and password input fields
  Form _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// Email input field.
          TextFormFieldWidget(
            label: AppStrings.email,
            hintText: AppStrings.emailHint,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          /// Password input field
          TextFormFieldWidget(
            label: AppStrings.password,
            isShowPassword: true,
            obscureText: true,
            validator: Validators.validatePassword,
            hintText: AppStrings.passwordHint,
            controller: authController.passwordController,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  /// Builds the "Forgot Password" button.
  Widget _buildForgetPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () async {
          await NetworkUtils.executeWithInternetCheck(
              action: () => Get.toNamed(RoutesName.forgetPassword));
        },
        child: Text(
          AppStrings.forgetPasswordTitle,
          style: AppsTextStyle.mediumBoldText.copyWith(
            color: AppColors.hintLight,
          ),
        ),
      ),
    );
  }

  /// Builds a divider with "OR" text in the center.
  Row _buildOrDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLine(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            AppStrings.withOr,
            style:
                AppsTextStyle.mediumNormalText.copyWith(color: AppColors.grey),
          ),
        ),
        _buildLine(),
      ],
    );
  }

  /// Builds the social login options row (e.g., Facebook and Gmail).
  Row _buildSocialLoginOptions() {
    return Row(
      children: [
        Expanded(
          /// Facebook login button.
          child: SocialButton(
            onTap: () async =>
                NetworkUtils.executeWithInternetCheck(action: () {}),
            color: AppColors.blue,
            iconPath: AppIcons.facebookIcon,
            label: AppStrings.btnFacebook,
          ),
        ),
        AppsFunction.horizontalSpacing(10),
        Expanded(
          /// Facebook login button.
          child: SocialButton(
            onTap: () async => await NetworkUtils.executeWithInternetCheck(
                action: () async => await authController.signInWithGoogle()),
            color: AppColors.red,
            iconPath: AppIcons.gmailIcon,
            label: AppStrings.btnGmail,
          ),
        ),
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

/*
  @override
  void dispose() {
    authController.dispose();
    super.dispose();
  } Why use authController.dispose and What is meaning it good way to declare this
#: Why use _configureStatusBar in didchagneDepence
#: 
4. Lifecycle Management Improvements
✅ Remove authController.dispose(); from dispose()
Reason:

Get.find<AuthController>() is managed by GetX, and disposing it manually can cause unintended issues.
Controllers registered with Get.put() or Get.lazyPut() are automatically managed

Ensured _configureStatusBar() is called in initState() instead of didChangeDependencies() (better placement).
*/
