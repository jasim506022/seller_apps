import 'package:flutter/material.dart';

class AddressModel with ChangeNotifier {
  String? city;
  String? completeaddress;
  String? country;
  String? deliveryplace;
  String? flatno;
  String? name;
  String? phone;
  String? streetno;
  String? village;
  String? addressId;

  AddressModel(
      {this.city,
      this.completeaddress,
      this.country,
      this.deliveryplace,
      this.flatno,
      this.name,
      this.phone,
      this.streetno,
      this.village,
      this.addressId});

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      city: map['city'] != null ? map['city'] as String : null,
      completeaddress: map['completeaddress'] != null
          ? map['completeaddress'] as String
          : null,
      country: map['country'] != null ? map['country'] as String : null,
      deliveryplace:
          map['deliveryplace'] != null ? map['deliveryplace'] as String : null,
      flatno: map['flatno'] != null ? map['flatno'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      streetno: map['streetno'] != null ? map['streetno'] as String : null,
      village: map['village'] != null ? map['village'] as String : null,
      addressId: map['addressId'] != null ? map['addressId'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'completeaddress': completeaddress,
      'country': country,
      'deliveryplace': deliveryplace,
      'flatno': flatno,
      'name': name,
      'phone': phone,
      'streetno': streetno,
      'village': village,
      'addressId': addressId,
    };
  }
}