import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/apps_color.dart';

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
                  color: AppColors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            width: 15.h,
          ),
          const Icon(
            Icons.error_sharp,
            color: AppColors.red,
          )
        ],
      ),
      content: Text(
        message,
        style: GoogleFonts.poppins(
            color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 14),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Okay",
              style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ))
      ],
    );
  }
}
