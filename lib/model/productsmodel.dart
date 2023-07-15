// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? productId;
  String? productcategory;
  String? productdescription;
  List<dynamic>? productimage;
  String? productname;
  double? productprice;
  double? productrating;
  int? discount;
  String? productunit;
  Timestamp? publishDate;

  ProductModel(
      {this.productId,
      this.productcategory,
      this.productdescription,
      this.productimage,
      this.productname,
      this.productprice,
      this.productrating,
      this.productunit,
      this.publishDate,
      this.discount});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      productcategory: map['productcategory'],
      productdescription: map['productdescription'],
      productimage: map['productimage'],
      productname: map['productname'],
      productprice: map['productprice'],
      productrating: map['productrating'],
      productunit: map['productunit'],
      publishDate: map['publishDate'],
      discount: map['discount'],
    );
  }
}
