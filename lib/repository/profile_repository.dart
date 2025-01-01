import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/response/service/data_profile_service.dart';
import '../res/app_function.dart';

class ProfileRepository {
  final profileService = DataProfileService();
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() async {
    try {
      return profileService.fetchUserProfile();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<void> updateUserProfile({required Map<String, dynamic> map}) async {
    try {
      await profileService.updateUserProfile(map: map);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
