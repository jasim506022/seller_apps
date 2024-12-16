import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/sign_in_controller.dart';
import '../../res/app_asset/icon_asset.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_color.dart';
import '../../res/apps_text_style.dart';

import '../../res/internet_utilis.dart';
import '../../res/routes/routes_name.dart';
import '../../widget/custom_auth_button_widget.dart';

import '../../widget/rich_text_widget.dart';

import '../../widget/show_alert_dialog_widget.dart';
import '../../widget/text_field_form_widget.dart';
import 'widget/app_sign_sign_page.dart';
import 'widget/social_button_widget.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final signInController = Get.find<SignInController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundLight,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    signInController.dispose();
    super.dispose();
  }

  /// A utility function to verify internet status before executing an action
  Future<void> verifyInternetAndExecute(Future<void> Function() action) async {
    if (!await NetworkUtili.verifyInternetStatus()) {
      await action();
    }
  }

  /// Navigate to the Forget Password page and clear input fields.
  Future<void> navigateToForgetPassword() async {
    Get.toNamed(RoutesName.forgetPassword);
    signInController.clearFields();
  }

  /// Displays a dialog asking the user for confirmation to exit the app.
  Future<bool> showExitDialog() async {
    return await Get.dialog<bool>(
          ShowAlertDialogWidget(
            icon: Icons.question_mark_rounded,
            title: AppString.exit,
            content: AppString.exitApps,
            onYesPressed: () => Get.back(result: true),
            onNoPressed: () => Get.back(result: false),
          ),
        ) ??
        false;
  }

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showExitDialog();
        if (shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
          await NetworkUtili.verifyInternetStatus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSignInPageIntro(
                    title: AppString.adminLogin,
                    description: AppString.logInPageSubjectTitle,
                  ),
                  _buildLoginForm(),
                  verticalSpace(5),
                  _buildForgetPasswordButton(),
                  verticalSpace(15),
                  CustomAuthButtonWidget(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      await verifyInternetAndExecute(
                        signInController.signInWithEmailAndPassword,
                      );
                    },
                    title: AppString.signIn,
                  ),
                  verticalSpace(25),
                  _buildOrDividerText(),
                  verticalSpace(20),
                  _buildSocialLoginOptions(),
                  verticalSpace(25),
                  RichTextWidget(
                    colorText: AppString.createAccount,
                    function: () async {
                      Get.toNamed(RoutesName.signupPage);
                    },
                    simpleText: AppString.dontHaveAccount,
                  ),
                  SizedBox(height: 0.12.sh),
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
            function: () async => NetworkUtili.verifyInternetStatus(),
            color: AppColors.blue,
            image: IconAsset.facebookIcon,
            title: AppString.facebook,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SocialButtonWidget(
            function: () async {
              await verifyInternetAndExecute(() async {
                await signInController.signWithGoogle();
              });
            },
            color: AppColors.red,
            image: IconAsset.gmailIcon,
            title: AppString.gmail,
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
          await verifyInternetAndExecute(navigateToForgetPassword);
        },
        child: Text(
          AppString.forgetPassword,
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

  /// Builds a divider with text in the center ("or").
  Row _buildOrDividerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLine(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            AppString.withOr,
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

/*
1. You are setting SystemUiOverlayStyle in didChangeDependencies. While this works, it's better to move such configurations to initState unless it depends on inherited widgets or context.
2. If SigninPage disposes SignInController, consider cleaning it explicitly to avoid memory leaks.
3.
*/


/*

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundLight,
          statusBarIconBrightness: Brightness.dark),
    );
    super.initState();
  }

  var signInController = Get.find<SignInController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    signInController.dispose();
    super.dispose();
  }

  Future<void> verifyInternetAndExecute(Future<void> Function() action) async {
    if (!(await NetworkUtili.verifyInternetStatus())) {
      await action();
    }
  }

  Future<void> navigateToForgetPassword() async {
    Get.toNamed(RoutesName.forgetPassword);
    signInController.cleanTextField();
  }

  Future<bool> showExitDialog() async {
    return await Get.dialog<bool>(
          ShowAlertDialogWidget(
            icon: Icons.question_mark_rounded,
            title: AppString.exit,
            content: AppString.exitApps,
            yesOnPress: () => Get.back(result: true),
            noOnPress: () => Get.back(result: false),
          ),
        ) ??
        false;
  }

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showExitDialog();
        if (shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          NetworkUtili.verifyInternetStatus();
        },
        child: Scaffold(
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
                  verticalSpace(5),
                  _buildForgetPasswordButton(),
                  verticalSpace(15),
                  CustomAuthButtonWidget(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      await verifyInternetAndExecute(
                          signInController.signInWithEmailAndPassword);
                    },
                    title: AppString.signIn,
                  ),
                  verticalSpace(25),
                  _buildOrDividerText(),
                  verticalSpace(20),
                  _buildSocialLoginOptions(),
                  verticalSpace(25),
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
          child: SocialButtonWidget(
              function: () async => NetworkUtili.verifyInternetStatus(),
              color: AppColors.blue,
              image: IconAsset.facebookIcon,
              title: AppString.facebook),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: SocialButtonWidget(
              function: () async => await verifyInternetAndExecute(
                  signInController.signWithGoogle),
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
            await verifyInternetAndExecute(navigateToForgetPassword);
          },
          child: Text(AppString.forgetPassword,
              style: AppsTextStyle.mediumBoldText.copyWith(
                color: AppColors.hintLight,
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
            style:
                AppsTextStyle.largeNormalText.copyWith(color: AppColors.grey),
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

*/