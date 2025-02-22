import 'package:seller_apps/res/app_string.dart';

import '../res/app_constants.dart';

class ProfileModel {
  String? address;
  num? earnings;
  String? email;
  String? imageurl;
  String? name;
  String? phone;
  String? status;
  String? uid;
  String? token;
  ProfileModel(
      {this.address,
      this.earnings,
      this.email,
      this.imageurl,
      this.name,
      this.phone,
      this.status,
      this.uid,
      this.token});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'earnings': earnings,
      'email': email,
      'imageurl': imageurl,
      'name': name,
      'phone': phone,
      'token': token,
      'status': AppStrings.approved,
      'uid': AppConstants.sharedPreference!.getString(AppStrings.prefUserId),
    };
  }

  Map<String, dynamic> toMapProfileEdit() {
    return <String, dynamic>{
      'address': address,
      'earnings':
          AppConstants.sharedPreference!.getDouble(AppStrings.prefUserEarnings),
      'email':
          AppConstants.sharedPreference!.getString(AppStrings.prefUserEmail),
      'imageurl': imageurl,
      'name': name,
      'phone': phone,
      'token': token,
      'status': AppStrings.approved,
      'uid': AppConstants.sharedPreference!.getString(AppStrings.prefUserId),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      address: map['address'] != null ? map['address'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      earnings: map['earnings'] != null ? map['earnings'] as num : null,
      email: map['email'] != null ? map['email'] as String : null,
      imageurl: map['imageurl'] != null ? map['imageurl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }
}
