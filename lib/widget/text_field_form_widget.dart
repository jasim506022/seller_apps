import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_function.dart';
import '../res/apps_text_style.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget(
      {super.key,
      this.hintText,
      required this.controller,
      this.autofocus = false,
      this.obscureText = false,
      this.isShowPassword = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.enabled = true,
      this.textInputType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.isUdateDecoration = false,
      this.decoration,
      this.label,
      this.style});
  final String? hintText;
  final TextEditingController controller;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final int? maxLines;
  bool obscureText;
  final bool isShowPassword;
  final bool enabled;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool isUdateDecoration;
  final InputDecoration? decoration;
  final TextStyle? style;

  final String? label;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Text(widget.label!, style: AppsTextStyle.labelTextStyle),
          AppsFunction.verticalSpace(8),
          TextFormField(
              onChanged: widget.onChanged,
              enabled: widget.enabled,
              controller: widget.controller,
              autofocus: widget.autofocus,
              maxLines: widget.maxLines,
              validator: widget.validator,
              obscureText: widget.obscureText,
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              style: widget.style ??
                  AppsTextStyle.textFieldInputTextStyle(widget.enabled),
              decoration: widget.isUdateDecoration
                  ? widget.decoration
                  : AppsFunction.textFormFielddecoration(
                      isEnable: widget.enabled,
                      hintText: widget.hintText!,
                      isShowPassword: widget.isShowPassword,
                      obscureText: widget.obscureText,
                      function: () {
                        widget.obscureText = !widget.obscureText;
                        setState(() {});
                      })),
        ],
      ),
    );
  }
}
