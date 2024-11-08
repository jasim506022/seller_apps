import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/routes/routes_name.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../service/database/firebasedatabase.dart';
import '../../widget/show_error_dialog_widget.dart';
import '../../widget/text_field_form_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailET = TextEditingController();

  @override
  void dispose() {
    _emailET.dispose();
    super.dispose();
  }

  Widget _buildForgetPassword() {
    return SizedBox(
      width: 1.sw,
      child: ElevatedButton(
        style: globalMethod.elevateButtonStyle(),
        onPressed: () async {
          try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              await FirebaseDatabase.forgetPasswordSnapshot(
                      email: _emailET.text)
                  .then((value) {
                globalMethod.flutterToast(msg: "Please Check Your mail");
                Navigator.pushReplacementNamed(context, RoutesName.signPage);
              }).catchError((error) {
                globalMethod.flutterToast(msg: "Error Occured: $error");
              });
            } else {
              globalMethod.flutterToast(msg: "No Internet Connection");
            }
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) {
                return ShowErrorDialogWidget(
                  message: e.toString(),
                  title: 'Error Occurred',
                );
              },
            );
          }
        },
        child: Text(
          "Reset Password",
          style: GoogleFonts.poppins(
              color: white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        color: white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Image.asset(
                  "asset/image/logo.png",
                  height: 0.177.sh,
                  width: 0.177.sh,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Forget Your Password?",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Please Enter your mail address to reset you password",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: hintLightColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormFieldWidget(
                  hintText: 'Email Address',
                  controller: _emailET,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    } else if (globalMethod.isValidEmail(value)) {
                      return 'Please Enter a Valid Email Address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                _buildForgetPassword(),
                SizedBox(
                  height: 2.h,
                ),
                globalMethod.buldRichText(
                    colorText: "Sign In",
                    context: context,
                    function: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesName.signPage);
                    },
                    simpleText: "If you don't want to reset Password? "),
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
}
