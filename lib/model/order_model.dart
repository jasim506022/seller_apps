import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String addressId;
  final num totalAmount;
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
    required this.totalAmount,
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
      totalAmount: data['totalAmount'],
      orderBy: data['orderBy'],
      productIds: List<String>.from(data['productIds']),
      paymentDetails: data['paymentDetails'],
      orderId: data['orderId'],
      seller: List<String>.from(
          data['seller']), //List<String>.from(data['seller']),
      orderTime: data['orderTime'],
      isSuccess: data['isSuccess'],
      status: data['status'],
      deliveryDate: data['deliveryDate'],
      deliveryPartner: data['deliveryPartner'],
      trackingNumber: data['trackingNumber'],
    );
  }

  // Convert the OrderModel instance into a Map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      "addressId": addressId,
      "totalAmountt": totalAmount,
      "orderBy": orderBy,
      "productIds": productIds,
      "paymentDetails": paymentDetails,
      "orderId": orderId,
      "seller": seller,
      "orderTime": orderTime,
      "isSuccess": isSuccess,
      "status": status,
      "deliveryDate": deliveryDate,
      "deliveryPartner": deliveryPartner,
      "trackingNumber": trackingNumber,
    };
  }
}
