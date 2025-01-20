import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../model/dashboard_grid_model.dart';
import 'grid_view_item.dart';

class DashboardGridView extends StatelessWidget {
  const DashboardGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: GridView.builder(
        itemCount: dashboardGridList.length,
        itemBuilder: (context, index) {
          final item = dashboardGridList[index];
          return GridViewItem(
            image: item.image,
            label: item.text,
            onTap: () {
              if (item.arguments != null) {
                Get.offAndToNamed(item.route, arguments: item.arguments);
              } else {
                Get.toNamed(item.route);
              }
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 15.h,
          childAspectRatio: .95,
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
