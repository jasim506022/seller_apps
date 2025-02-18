import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'filter_dialog_content_widget.dart';

/// **ProductFilterDialog**
/// A reusable alert dialog widget for filtering products.
/// It displays filter options using the `FilterDialogContentWidget`
class ProductFilterDialog extends StatelessWidget {
  const ProductFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      content: const FilterDialogContentWidget(),
    );
  }
}
