import 'package:firebase_auth/firebase_auth.dart';

import '../data/response/service/data_firebase_service.dart';

class SplashRepository {
  var dataFirebaseService = DataFirebaseService();
  User? getCurrentUser() {
    return dataFirebaseService.getCurrentUser();
  }
}
