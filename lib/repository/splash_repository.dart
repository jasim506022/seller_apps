import 'package:firebase_auth/firebase_auth.dart';
import 'package:seller_apps/res/app_function.dart';

import '../data/response/service/data_firebase_service.dart';

class SplashRepository {
  var dataFirebaseService = DataFirebaseService();
  User? getCurrentUser() {
    try {
      return dataFirebaseService.getCurrentUser();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
