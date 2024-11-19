import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/apps_text_style.dart';


class DropdownCategoryWidget extends StatelessWidget {
  const DropdownCategoryWidget({
    super.key,
    this.isSearch = false,
    this.onChanged,
    this.onChangeds,
    this.category,
    this.value,
    required this.list,
  });
  final String? category;
  final String? value;
  final bool isSearch;
  final void Function(String?)? onChanged;
  final void Function(String?)? onChangeds;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
 
    return DropdownButtonFormField(
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15.r)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      ),
      value: isSearch ? category : value,
      isExpanded: true,
      style: AppsTextStyle.mediumBoldText,
      focusColor: Theme.of(context).primaryColor,
      elevation: 16,
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),

      // items,
      onChanged: isSearch ? onChanged : onChangeds,
    );
  }
}

/*
categoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
*/
