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
    /// Get the `ProfileController`.
    final ProfileController profileController = Get.find<ProfileController>();

    // Attempt to fetch locally cached profile data from shared preferences
    final profileData = _fetchLocalProfileData();

    /// If local profile data is available, use it directly
    if (profileData != null) {
      return UserProfileHeader(
        imageUrl: profileData['imageUrl']!,
        name: profileData['name']!,
        email: profileData['email']!,
      );
    }

    /// If no cached data is found, fetch profile from Database
    return _fetchAndBuildProfile(profileController);
  }

  /// Fetches the user profile data from shared preferences.
  /// Returns `null` if no valid data is found.
  Map<String, String>? _fetchLocalProfileData() {
    var pref = AppConstants.sharedPreference;
    final image = pref?.getString(AppStrings.prefUserProfilePic);
    final name = pref?.getString(AppStrings.prefUserName);
    final email = pref?.getString(AppStrings.prefUserEmail);

    /// Ensure all values are valid before returning the cached data
    if ([image, name, email].every((val) => val?.isNotEmpty ?? false)) {
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
        }
        if (snapshot.hasError || snapshot.data == null) {
          return const LoadingProfileHeaderWidget(); // Error fallback
        }

        final data = snapshot.data!.data();

        final profileModel = ProfileModel.fromMap(data!);
        // Display the user's profile header with fallback values if any field is null
        return UserProfileHeader(
          imageUrl: profileModel.imageurl ?? AppStrings.defaultImage,
          name: profileModel.name ?? AppStrings.defaultName,
          email: profileModel.email ?? AppStrings.defaultEmail,
        );
      },
    );
  }
}

/*
#: Why doesn't Use Stream builder why use where is Future Builder
#: Understand Clear Null (?. and !)
#: Understand Profile Controller  (FetchUserProfileStream)
#: Why use Future Builder Why no StreamBuilder
#: Separation of Concerns (SoC)
#:
why use it if ([image, name, email].every((val) => val?.isNotEmpty ?? false)) {
      return {'imageUrl': image!, 'name': name!, 'email': email!};
    }
    instead of 
if ((image?.isNotEmpty ?? false) &&
        (name?.isNotEmpty ?? false) &&
        (email?.isNotEmpty ?? false)) {
      return {'imageUrl': image!, 'name': name!, 'email': email!};
    }
    why use
*/
