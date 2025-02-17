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
    text: AppStrings.allProducts,
    route: RoutesName.mainPage,
    arguments: 1,
  ),
  DashboardGridModel(
    image: AppImage.totalsalesImages,
    text: AppStrings.totalSales,
    route: RoutesName.totalSales,
  ),
  DashboardGridModel(
    image: AppImage.runningOrderImages,
    text: AppStrings.runningOrders,
    route: RoutesName.orderPage,
  ),
  DashboardGridModel(
    image: AppImage.completeOrderImages,
    text: AppStrings.completeOrder,
    route: RoutesName.completeOrderPage,
  ),
];
