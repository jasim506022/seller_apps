import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/dashboard_grid_model.dart';
import 'grid_item_widget.dart';

/// **DashboardGridView**
/// A grid view widget that displays a collection of items on the dashboard.
/// Each item can be tapped to navigate to another page.
class DashboardGridWidget extends StatelessWidget {
  const DashboardGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashboardGridList.length,
        itemBuilder: (context, index) {
          final gridItem = dashboardGridList[index];
          return GridItemWidet(
            image: gridItem.image,
            label: gridItem.label,
            onTap: () {
              // Navigate to the corresponding route when an item is tapped
              if (gridItem.arguments != null) {
                Get.offAndToNamed(gridItem.destinationRoute,
                    arguments: gridItem.arguments);
              } else {
                Get.toNamed(gridItem
                    .destinationRoute); // Navigate to the route without arguments
              }
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20.w, // Space between columns
          mainAxisSpacing: 15.h,
          childAspectRatio: .95,
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
