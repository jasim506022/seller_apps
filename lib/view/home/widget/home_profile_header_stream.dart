import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';
import '../../../model/profile_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import '../../loading_widget/loading_profile_header_widget.dart';
import 'user_profile_header.dart';

/// Displays the user's profile header in the home page.
/// Fetches profile data either from shared preferences (cached) or the API (fallback).
class HomeProfileHeaderStream extends StatelessWidget {
  const HomeProfileHeaderStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    final profileData = _fetchLocalProfileData();

    /// If local profile data is available, use it directly
    if (profileData != null) {
      return UserProfileHeader(
        imageUrl: profileData['imageUrl']!,
        name: profileData['name']!,
        email: profileData['email']!,
      );
    }

    /// Otherwise, fetch from the API
    return _fetchAndBuildProfile(profileController);
  }

  /// Fetches the user profile data from shared preferences.
  /// Returns `null` if no valid data is found.
  Map<String, String>? _fetchLocalProfileData() {
    final image = AppConstants.sharedPreference
        ?.getString(AppStrings.imageurlSharedPreference);
    final name = AppConstants.sharedPreference
        ?.getString(AppStrings.nameSharedPreference);
    final email = AppConstants.sharedPreference
        ?.getString(AppStrings.emailSharedPreference);

    /// Ensure all values are valid before returning
    if ((image?.isNotEmpty ?? false) &&
        (name?.isNotEmpty ?? false) &&
        (email?.isNotEmpty ?? false)) {
      return {'imageUrl': image!, 'name': name!, 'email': email!};
    }
    return null; // No valid data found
  }

  /// Fetches user profile data from API and builds the UI.
  Widget _fetchAndBuildProfile(ProfileController controller) {
    return FutureBuilder(
      future: controller.fetchUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingProfileHeaderWidget();
        } else if (snapshot.hasData) {
          final data = snapshot.data!.data();
          if (data != null) {
            final profileModel = ProfileModel.fromMap(data);
            return UserProfileHeader(
              imageUrl: profileModel.imageurl ?? AppStrings.defaultImage,
              name: profileModel.name ?? AppStrings.defaultName,
              email: profileModel.email ?? AppStrings.defaultEmail,
            );
          }
        }
        return const LoadingProfileHeaderWidget(); // Default fallback
      },
    );
  }
}

/*
#: Why doesn't Use Stream builder why use where is Future Builder
#: Understand Clear Null (?. and !)
#: Understand Profile Controller  (FetchUserProfileStream)
#: Why use Future Builder Why no StreamBuilder
*/