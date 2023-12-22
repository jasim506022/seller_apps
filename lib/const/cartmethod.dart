import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/database/firebasedatabase.dart';
import 'package:seller_apps/model/productsmodel.dart';

import '../service/provider/totalamountprovider.dart';

class CartMethods {
  static List<ProductModel> allProductList = [];

  static allProduct() async {
    FirebaseDatabase.allSellerProductList().then((snashot) {
      for (var doc in snashot.docs) {
        ProductModel product = ProductModel.fromMap(doc.data());
        allProductList.add(product);
      }
    });
  }

  static void allSellMoeny(BuildContext context) async {
    FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "deliver")
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> seller) {
      for (var i = 0; i < seller.docs.length; i++) {
        FirebaseFirestore.instance
            .collection("seller")
            .doc(sharedPreference!.getString("uid")!)
            .collection("products")
            .where("productId",
                whereIn: CartMethods.separteOrderProductIdList(
                    (seller.docs[i].data())["productIds"]))
            .snapshots()
            .listen((event) {
          List<dynamic> listItem = CartMethods.separateOrderItemQuantities(
              (seller.docs[i].data())["productIds"]);
          for (var p = 0; p < event.docs.length; p++) {
            Future.delayed(Duration.zero, () {
              Provider.of<TotalAmountProvider>(context, listen: false)
                  .setAmount(
                      amount: listItem[p] * event.docs[p]['productprice']);
            });
            print(listItem[p] * event.docs[p]['productprice']);
          }
        });
      }
    });
  }

  static separateOrderSellerCartList(productIds) {
    List<String> userCartList = List<String>.from(productIds);
    List<String> itemSellerDetails = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var lastChaterPositionOfItembeforeColon = item.lastIndexOf(":");
      String getItemId = item.substring(0, lastChaterPositionOfItembeforeColon);
      var colonAndAfterCharaList = getItemId.split(":").toList();
      String sellerItemId = colonAndAfterCharaList[1].toString();
      itemSellerDetails.add(sellerItemId);
    }
    if (kDebugMode) {
      print(itemSellerDetails);
    }
    return itemSellerDetails;
  }

  static separteOrderProductIdList(productIds) {
    List<dynamic> userCartList = List<dynamic>.from(productIds);
    List<String> itemIDDetails = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();

      var lastChaterPositionOfItembeforeColon = item.indexOf(":");
      String getItemId = item.substring(0, lastChaterPositionOfItembeforeColon);

      itemIDDetails.add(getItemId);
    }
    print("Bangladesh ${itemIDDetails.length}");
    return itemIDDetails;
  }

  static separateOrderItemQuantities(productIds) {
    List<String> userCartList = List<String>.from(productIds);
    dynamic itemQuantity = [];
    List<String> customList = separteOrderProductIdList(productIds);
    List<ProductModel> filteredProducts = [];
    for (String itemId in customList) {
      List<ProductModel> matchProductList = allProductList
          .where((ProductModel product) => product.productId == itemId)
          .toList();

      if (matchProductList.isNotEmpty) {
        filteredProducts.addAll(matchProductList);
      }
    }

    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var lastChaterPositionOfItembeforeColon = item.indexOf(":");
      String getItemId = item.substring(0, lastChaterPositionOfItembeforeColon);
      for (int i = 0; i < filteredProducts.length; i++) {
        if (filteredProducts[i].productId == getItemId) {
          var colonAndafterCharaListh = item.split(":").toList();
          int qunatityNumber = int.parse(colonAndafterCharaListh[2].toString());
          itemQuantity.add(qunatityNumber);
        }
      }
    }

    if (kDebugMode) {
      print("Item Qunaity List: ${itemQuantity.length}");
    }

    return itemQuantity;
  }
}
