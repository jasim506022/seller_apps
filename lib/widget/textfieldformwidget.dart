import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldFormWidget extends StatelessWidget {
  TextFieldFormWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      this.autofocus = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.textInputType = TextInputType.text});
  final String hintText;
  final TextEditingController controller;
  bool? autofocus;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          controller: controller,
          autofocus: autofocus!,
          maxLines: maxLines,
          validator: (value) {
            if (value!.isEmpty) {
              return "Field Doesn't Empty";
            }
          },
          textInputAction: textInputAction,
          keyboardType: textInputType,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            fillColor: const Color(0xfff2f2f8),
            filled: true,
            labelStyle:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            hintStyle: const TextStyle(
              color: Color(0xffc8c8d5),
            ),
          )),
    );
  }
}

class TextFieldForProfile extends StatelessWidget {
  TextFieldForProfile(
      {super.key,
      required this.controller,
      this.autofocus = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.enabled = true,
      this.textInputType = TextInputType.text});

  final TextEditingController controller;
  bool? autofocus;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  int? maxLines;
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          enabled: enabled,
          controller: controller,
          autofocus: autofocus!,
          maxLines: maxLines,
          validator: (value) {
            if (value!.isEmpty) {
              return "Field Doesn't Empty";
            }
          },
          textInputAction: textInputAction,
          keyboardType: textInputType,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            fillColor: const Color(0xfff2f2f8),
            filled: true,
            labelStyle:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            hintStyle: const TextStyle(
              color: Color(0xffc8c8d5),
            ),
          )),
    );
  }
}
