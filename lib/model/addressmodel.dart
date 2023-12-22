// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddressModel {
  String? city;
  String? completeaddress;
  String? country;
  String? deliveryplace;
  String? flatno;
  String? name;
  String? phone;
  String? streetno;
  String? village;
  String? id;

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
      this.id});

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
      id: map['id'] != null ? map['id'] as String : null,
    );
  }
}
