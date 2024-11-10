
import '../data/response/service/data_firebase_service.dart';

import '../res/app_function.dart';

class ForgetPasswordRepository {
  final _dataFirebaseService = DataFirebaseService();

  Future<void> forgetPasswordSnapshot({required String email}) async {
    try {
      await _dataFirebaseService.forgetPasswordSnapshot(email: email);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}