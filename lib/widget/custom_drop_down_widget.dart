import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/apps_text_style.dart';

/// A reusable dropdown widget with a customizable list of items.
class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({
    super.key,
    this.onChanged, // Callback function triggered when an item is selected
    required this.value,
    required this.items,
  });

  /// The currently selected value in the dropdown.

  final String value;

  /// Callback function triggered when an item is selected.

  final void Function(String?)? onChanged;

  /// List of items displayed in the dropdown.

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        filled: true,
        enabledBorder: _buildDropdownItems(),
        focusedBorder: _buildDropdownItems(),
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      ),
      value: value,
      style: AppsTextStyle.mediumBoldText,
      items: items
          .map<DropdownMenuItem<String>>((String value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
          .toList(),
      onChanged: onChanged,
    );
  }

  /// Builds a rounded border for the input field.
  OutlineInputBorder _buildDropdownItems() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
      ),
      borderRadius: BorderRadius.circular(15.r),
    );
  }
}
