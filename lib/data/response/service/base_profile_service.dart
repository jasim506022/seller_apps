import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseProfileService {
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserProfile();
  Future<void> updateProfile({required Map<String, dynamic> map});
}
