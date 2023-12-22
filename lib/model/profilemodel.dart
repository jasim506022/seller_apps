// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  String? address;
  double? earnings;
  String? email;
  String? imageurl;
  String? name;
  String? phone;
  String? status;
  String? uid;
  ProfileModel(
      {this.address,
      this.earnings,
      this.email,
      this.imageurl,
      this.name,
      this.phone,
      this.status,
      this.uid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'earnings': earnings,
      'email': email,
      'imageurl': imageurl,
      'name': name,
      'phone': phone,
      'uid': uid,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      address: map['address'],
      earnings: map['earnings'],
      email: map['email'],
      imageurl: map['imageurl'],
      name: map['name'],
      phone: map['phone'],
      status: map['status'],
      uid: map['uid'],
    );
  }
}
