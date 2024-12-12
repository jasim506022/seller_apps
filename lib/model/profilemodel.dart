// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/res/app_string.dart';

class ProfileModel {
  String? address;
  num? earnings;
  String? email;
  String? imageurl;
  String? name;
  String? phone;
  String? status;
  String? uid;
  ProfileModel({
    this.address,
    this.earnings,
    this.email,
    this.imageurl,
    this.name,
    this.phone,
    this.status,
    this.uid,
  });

  ProfileModel copyWith({
    String? address,
    double? earnings,
    String? email,
    String? imageurl,
    String? name,
    String? phone,
    String? status,
    String? uid,
  }) {
    return ProfileModel(
      address: address ?? this.address,
      earnings: earnings ?? this.earnings,
      email: email ?? this.email,
      imageurl: imageurl ?? this.imageurl,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'earnings': earnings,
      'email': email,
      'imageurl': imageurl,
      'name': name,
      'phone': phone,
      'status': AppString.approved,
      'uid': sharedPreference!.getString(AppString.uidSharedPreference),
    };
  }

  Map<String, dynamic> toMapProfileEdit() {
    return <String, dynamic>{
      'address': address,
      'earnings':
          sharedPreference!.getDouble(AppString.earningSharedPreference),
      'email': sharedPreference!.getString(AppString.emailSharedPreference),
      'imageurl': imageurl,
      'name': name,
      'phone': phone,
      'status': AppString.approved,
      'uid': sharedPreference!.getString(AppString.uidSharedPreference),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      address: map['address'] != null ? map['address'] as String : null,
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
