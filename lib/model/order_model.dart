import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String addressId;
  final num totalamount;
  final String orderBy;
  final List<String> productIds;
  final String paymentDetails;
  final String orderId;
  final List<String> seller;
  final String orderTime;
  final bool isSuccess;
  final String status;
  final String deliveryDate;
  final String deliveryPartner;
  final String trackingNumber;

  OrderModel({
    required this.addressId,
    required this.totalamount,
    required this.orderBy,
    required this.productIds,
    required this.paymentDetails,
    required this.orderId,
    required this.seller,
    required this.orderTime,
    required this.isSuccess,
    required this.status,
    required this.deliveryDate,
    required this.deliveryPartner,
    required this.trackingNumber,
  });

  // Factory constructor to create an instance from a Map (for Firestore or any other source)
  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      addressId: data['addressId'],
      totalamount: data['totalamount'],
      orderBy: data['orderBy'],
      productIds: List<String>.from(data['productIds']),
      paymentDetails: data['paymentDetails'],
      orderId: data['orderId'],
      seller: List<String>.from(
          data['seller']), //List<String>.from(data['seller']),
      orderTime: data['orderTime'],
      isSuccess: data['isSuccess'],
      status: data['status'],
      deliveryDate: data['deliverydate'],
      deliveryPartner: data['deliverypartner'],
      trackingNumber: data['trackingnumber'],
    );
  }

  // Convert the OrderModel instance into a Map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      "addressId": addressId,
      "totalamount": totalamount,
      "orderBy": orderBy,
      "productIds": productIds,
      "paymentDetails": paymentDetails,
      "orderId": orderId,
      "seller": seller,
      "orderTime": orderTime,
      "isSuccess": isSuccess,
      "status": status,
      "deliverydate": deliveryDate,
      "deliverypartner": deliveryPartner,
      "trackingnumber": trackingNumber,
    };
  }
}
