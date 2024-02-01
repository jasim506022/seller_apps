import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';

// ignore: must_be_immutable
class TextFieldFormWidget extends StatefulWidget {
  TextFieldFormWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      this.autofocus = false,
      this.obscureText = false,
      this.isShowPassword = false,
      this.enable = true,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      required this.validator});
  final String hintText;
  final TextEditingController controller;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool enable;
  bool? obscureText;
  final bool? isShowPassword;
  final String? Function(String?)? validator;

  @override
  State<TextFieldFormWidget> createState() => _TextFieldFormWidgetState();
}

class _TextFieldFormWidgetState extends State<TextFieldFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * .012),
      child: TextFormField(
          controller: widget.controller,
          autofocus: widget.autofocus!,
          maxLines: widget.maxLines,
          validator: widget.validator,
          enabled: widget.enable,
          obscureText: widget.obscureText!,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: widget.enable
                  ? Theme.of(context).primaryColor
                  : Colors.black54),
          decoration: globalMethod.textFormFielddecoration(
              hintText: widget.hintText,
              isShowPassword: widget.isShowPassword!,
              obscureText: widget.obscureText!,
              function: () {
                widget.obscureText = !widget.obscureText!;
                setState(() {});
              })),
    );
  }
}
