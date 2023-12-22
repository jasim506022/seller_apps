import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PaswordTextFieldWidget extends StatefulWidget {
  PaswordTextFieldWidget({
    super.key,
    this.obscureText = true,
    required this.hintText,
    required this.controller,
    required this.validator,
  });
  bool? obscureText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  State<PaswordTextFieldWidget> createState() => _PaswordTextFieldWidgetState();
}

class _PaswordTextFieldWidgetState extends State<PaswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
          obscureText: widget.obscureText!,
          decoration: textFormFielddecoration(isPassword: true)),
    );
  }

  InputDecoration textFormFielddecoration({required bool isPassword}) {
    return InputDecoration(
      labelStyle:
          GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      fillColor: const Color(0xfff2f2f8),
      filled: true,
      hintText: widget.hintText,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
      suffixIcon: isPassword
          ? IconButton(
              onPressed: () {
                widget.obscureText = !widget.obscureText!;
                setState(() {});
              },
              icon: const Icon(
                Icons.password,
                color: Color(0xff686874),
              ))
          : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      hintStyle: const TextStyle(
        color: Color(0xffc8c8d5),
      ),
    );
  }
}
