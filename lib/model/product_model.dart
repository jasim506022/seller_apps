// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  String? productId;
  String? sellerId;
  String? sellerName;
  String? productname;
  String? productcategory;
  num? productprice;
  String? productunit;
  double? productrating;
  String? productdescription;
  Timestamp? publishDate;
  num? discount;
  List<dynamic>? productimage;
  String? stutus;

  ProductModel(
      {this.productId,
      this.sellerId,
      this.sellerName,
      this.productname,
      this.productcategory,
      this.productprice,
      this.productunit,
      this.productrating,
      this.productdescription,
      this.publishDate,
      this.discount,
      this.productimage,
      this.stutus});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] != null ? map['productId'] as String : null,
      sellerId: map['sellerId'] != null ? map['sellerId'] as String : null,
      sellerName:
          map['sellerName'] != null ? map['sellerName'] as String : null,
      productname:
          map['productname'] != null ? map['productname'] as String : null,
      productcategory: map['productcategory'] != null
          ? map['productcategory'] as String
          : null,
      productprice:
          map['productprice'] != null ? map['productprice'] as num : null,
      productunit:
          map['productunit'] != null ? map['productunit'] as String : null,
      productrating:
          map['productrating'] != null ? map['productrating'] as double : null,
      productdescription: map['productdescription'] != null
          ? map['productdescription'] as String
          : null,
      publishDate: map['publishDate'],
      discount: map['discount'] != null ? map['discount'] as num : null,
      productimage: map['productimage'],
      stutus: map['stutus'] != null ? map['stutus'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'productname': productname,
      'productcategory': productcategory,
      'productprice': productprice,
      'productunit': productunit,
      'productrating': productrating,
      'productdescription': productdescription,
      'publishDate': publishDate,
      'discount': discount,
      'productimage': productimage,
      'stutus': stutus,
    };
  }
}
