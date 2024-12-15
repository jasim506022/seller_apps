import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/res/routes/routes_name.dart';

import '../res/apps_color.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool isBackScreenButton;
  final Function? onOkayPressed;

  const CustomDialogWidget({
    super.key,
    required this.title,
    required this.content,
    this.isBackScreenButton = false,
    this.onOkayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColors.greenColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.poppins(
          color: Theme.of(context).primaryColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (onOkayPressed != null) {
              onOkayPressed!();
            } else {
              Navigator.pop(context);
            }
          },
          child: const Text("Okay"),
        ),
        TextButton(
          onPressed: () {
            if (isBackScreenButton) {
              Navigator.popUntil(
                  context, ModalRoute.withName(RoutesName.mainPage));
            } else {
              Navigator.pop(context, true);
            }
          },
          child: const Text("No"),
        ),
      ],
    );
  }
}
