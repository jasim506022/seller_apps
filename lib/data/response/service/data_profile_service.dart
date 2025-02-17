import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_string.dart';
import 'base_profile_service.dart';

class DataProfileService extends BaseProfileService {
  final _firebaseFirestore = FirebaseFirestore.instance;
  //
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile() {
    return _firebaseFirestore
        .collection(AppStrings.sellersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Future<void> updateUserProfile({required Map<String, dynamic> map}) async {
    _firebaseFirestore
        .collection(AppStrings.sellersCollection)
        .doc(AppConstants.sharedPreference
            ?.getString(AppStrings.uidSharedPreference))
        .update(map);
  }
}
