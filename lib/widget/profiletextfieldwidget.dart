import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable

class ProfileTextFieldFormWidget extends StatelessWidget {
  ProfileTextFieldFormWidget(
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
            return null;
          },
          textInputAction: textInputAction,
          keyboardType: textInputType,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: enabled == false ? Colors.black54 : Colors.black),
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 245, 245, 248),
            filled: true,
            labelStyle:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15)),
            enabledBorder: OutlineInputBorder(
                borderSide: enabled == false
                    ? BorderSide.none
                    : const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: enabled == false
                    ? BorderSide.none
                    : const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          )),
    );
  }
}
