// import 'package:firebase_auth/firebase_auth.dart';

// import '../data/response/service/data_firebase_service.dart';
// import '../model/profile_model.dart';
// import '../res/app_function.dart';

// class SignInRepository {
//   final _dataFirebaseService = DataFirebaseService();

//   Future<UserCredential> signInWithEmailAndPassword(
//       {required String email, required String password}) async {
//     try {
//       return await _dataFirebaseService.signInWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       AppsFunction.handleException(e);
//       rethrow;
//     }
//   }

//   Future<UserCredential?> signWithGoogle() async {
//     try {
//       return await _dataFirebaseService.signWithGoogle();
//     } catch (e) {
//       AppsFunction.handleException(e);
//       rethrow;
//     }
//   }

//   Future<bool> userExists() async {
//     try {
//       return await _dataFirebaseService.userExists();
//     } catch (e) {
//       AppsFunction.handleException(e);
//       rethrow;
//     }
//   }

//   Future<void> createUserGmail(
//       {required User user, required ProfileModel profileModel}) async {
//     try {
//       await _dataFirebaseService.createUserGmail(
//           user: user, profileModel: profileModel);
//     } catch (e) {
//       AppsFunction.handleException(e);
//     }
//   }
// }

