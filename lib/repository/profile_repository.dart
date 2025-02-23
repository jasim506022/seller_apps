import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/response/service/data_profile_service.dart';
import '../res/app_function.dart';

class ProfileRepository {
  final dataService = DataProfileService();

  /// Retrieves the user profile from Firestore.

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() async {
    try {
      return await dataService.fetchUserProfile();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  /// Updates the user profile in Firestore.
  Future<void> updateProfile({required Map<String, dynamic> map}) async {
    try {
      await dataService.updateProfile(map: map);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
