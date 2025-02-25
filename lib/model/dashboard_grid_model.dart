import '../res/app_asset/image_asset.dart';
import '../res/app_string.dart';
import '../res/routes/routes_name.dart';

/// **DashboardGridModel**
/// Represents a grid item in the dashboard with an image, label text, route for navigation, and optional arguments.
class DashboardGridModel {
  final String image;
  final String label;
  final String destinationRoute;
  final int? arguments;

  // Constructor for initializing the grid item properties
  DashboardGridModel({
    required this.image,
    required this.label,
    required this.destinationRoute,
    this.arguments,
  });
}

// List of all the grid items to be displayed on the dashboard
final List<DashboardGridModel> dashboardGridList = [
  DashboardGridModel(
    image: AppImage.allProductImage,
    label: AppStrings.allProductsTitle,
    destinationRoute: RoutesName.mainPage,
    arguments: 1,
  ),
  DashboardGridModel(
    image: AppImage.totalsalesImages,
    label: AppStrings.totalSalesTitle,
    destinationRoute: RoutesName.totalSales,
  ),
  DashboardGridModel(
    image: AppImage.runningOrderImages,
    label: AppStrings.runningOrdersTitle,
    destinationRoute: RoutesName.orderPage,
  ),
  DashboardGridModel(
    image: AppImage.completeOrderImages,
    label: AppStrings.completeOrderLabel,
    destinationRoute: RoutesName.completeOrderPage,
  ),
];
