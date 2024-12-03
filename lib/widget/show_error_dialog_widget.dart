import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/gobalcolor.dart';

class ShowErrorDialogWidget extends StatelessWidget {
  const ShowErrorDialogWidget({
    super.key,
    required this.title,
    required this.message,
  });

  final String title, message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Flexible(
            child: Text(
              "$title Error",
              style: GoogleFonts.poppins(
                  color: black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: 15.h,
          ),
          Icon(
            Icons.error_sharp,
            color: red,
          )
        ],
      ),
      content: Text(
        message,
        style: GoogleFonts.poppins(
            color: black, fontWeight: FontWeight.w500, fontSize: 14),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Okay",
              style: GoogleFonts.poppins(
                  color: black, fontWeight: FontWeight.bold, fontSize: 16),
            ))
      ],
    );
  }
}
