import '../res/app_asset/image_asset.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';

class DashboardGridModel {
  final String image;
  final String text;
  final String route;
  final int? arguments;

  DashboardGridModel({
    required this.image,
    required this.text,
    required this.route,
    this.arguments,
  });
}

final List<DashboardGridModel> dashboardGridList = [
  DashboardGridModel(
    image: AppImage.allProductImage,
    text: AppString.allProduct,
    route: RoutesName.mainPage,
    arguments: 1,
  ),
  DashboardGridModel(
    image: AppImage.totalsalesImages,
    text: AppString.totalSales,
    route: RoutesName.totalSales,
  ),
  DashboardGridModel(
    image: AppImage.runningOrderImages,
    text: AppString.runningOrder,
    route: RoutesName.orderPage,
  ),
  DashboardGridModel(
    image: AppImage.completeOrderImages,
    text: AppString.completeOrder,
    route: RoutesName.completeOrderPage,
  ),
];
