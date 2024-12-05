import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/response/service/data_firebase_service.dart';
import '../res/app_function.dart';

class ProfileRepository {
  final _dataFirebaseService = DataFirebaseService();
  Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserInformationSnapshot() async {
    try {
      return _dataFirebaseService.getUserInformationSnapshot();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _dataFirebaseService.signOutApp();
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
