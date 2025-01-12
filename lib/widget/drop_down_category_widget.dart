import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_text_style.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    super.key,
    this.onChanged,
    required this.value,
    required this.items,
  });

  final String value;

  final void Function(String?)? onChanged;

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        filled: true,
        enabledBorder: _buildBorder(context),
        focusedBorder: _buildBorder(context),
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      ),
      value: value,
      // isExpanded: true,
      style: AppsTextStyle.mediumBoldText,
      focusColor: Theme.of(context).primaryColor,
      elevation: 16,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: onChanged,
    );
  }

  /// Builds a rounded border for the input field.
  OutlineInputBorder _buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
      ),
      borderRadius: BorderRadius.circular(15.r),
    );
  }
}
