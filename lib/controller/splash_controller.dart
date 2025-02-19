import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../res/app_constants.dart';
import '../../res/routes/routes_name.dart';
import '../model/app_exception.dart';
import '../repository/splash_repository.dart';
import '../res/app_asset/icon_asset.dart';
import '../res/app_string.dart';
import '../widget/error_dialog_widget.dart';

/// `SplashController` handles the logic for the splash page, including navigation
/// and UI configuration. It determines whether the user should go to the main page,
/// onboarding, or sign-in page.
class SplashController extends GetxController {
  /// Repository to manage user-related operations.
  SplashRepository repository;

  SplashController({required this.repository});

  @override
  void onInit() {
    // Navigate to the next page based on app logic
    _navigateToNextPage();

    _configureUI();
    super.onInit();
  }

  /// Determines the next page based on user authentication state and onboarding status.
  void _navigateToNextPage() {
    try {
      Future.delayed(
        // Delay for 2 seconds to simulate a splash effect
        const Duration(seconds: 2),
        () {
          var currentUser = repository.getCurrentUser();
          // Determine the next route based on user authentication and onboarding status
          final route = currentUser != null
              // If user is logged in, navigate to the main page
              ? RoutesName.mainPage
              : (AppConstants.isViewed != 0
                  ? RoutesName.onBardingPpage
                  : RoutesName.signPage);
// Navigate to the determined route and remove splash from history
          Get.offNamed(route);
        },
      );
    } catch (e) {
      if (e is AppException) {
        Get.dialog(
          ErrorDialogWidget(
            icon: AppIcons.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: AppStrings.okay,
          ),
        );
      }
    }
  }

  @override
  void onClose() {
    // Restore system UI elements when the splash page is closed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }

  /// Configures the UI settings to make the splash page immersive (fullpage).
  void _configureUI() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode
          .immersive, // Hides the status and navigation bars for an immersive experience
    );
  }
}
