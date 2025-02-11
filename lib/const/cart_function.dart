import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/service/database/firebasedatabase.dart';
import 'package:seller_apps/model/product_model.dart';

import '../res/app_constants.dart';
import '../service/provider/totalamountprovider.dart';

class CartFunctions {
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
        .where("status", isEqualTo: "complete")
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> seller) {
      for (var i = 0; i < seller.docs.length; i++) {
        FirebaseFirestore.instance
            .collection("seller")
            .doc(AppConstants.sharedPreference!.getString("uid")!)
            .collection("products")
            .where("productId",
                whereIn: CartFunctions.separteOrderProductIdList(
                    (seller.docs[i].data())["productIds"]))
            .snapshots()
            .listen((event) {
          List<dynamic> listItem = CartFunctions.separateOrderItemQuantities(
              (seller.docs[i].data())["productIds"]);
          for (var p = 0; p < event.docs.length; p++) {
            Future.delayed(Duration.zero, () {
              // ignore: use_build_context_synchronously
              Provider.of<TotalAmountProvider>(context, listen: false)
                  .setAmount(amount: 0
                      // amount: listItem[p] *
                      //    AppConstants. globalMethod.discountedPrice(
                      //         event.docs[p]['productprice'],
                      //         event.docs[p]['discount'])

                      );
            });
            if (kDebugMode) {
              print(listItem[p] * event.docs[p]['productprice']);
            }
          }
        });
      }
    });
  }

/*
  static separateOrderSellerCartList(List<dynamic> productIds) {
    List<String> userCartList = List<String>.from(productIds);
    Set<String> itemSellerDetails = {};
    List<String> itemNumber = [];
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
    for (var i = 0; i < itemSellerDetails.length; i++) {
      if (itemSellerDetails[i] ==
          AppConstants.sharedPreference!.getString("uid")) {
        itemNumber.add(userCartList[i + 1]);
      }
    }
    return itemSellerDetails;
  }
*/

  static List<String> separateOrderSellerCartList(List<dynamic> seller) {
    return [for (var item in seller) item.toString().split(":")[0]];
  }
/*
// Seperator Oorder Product Id List
  static separteOrderProductIdList(productIds) {
    List<dynamic> userCartList = List<dynamic>.from(productIds);
   
    List<String> itemIDDetails = [];
    
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();

      var lastChaterPositionOfItembeforeColon = item.indexOf(":");
      String getItemId = item.substring(0, lastChaterPositionOfItembeforeColon);

      itemIDDetails.add(getItemId);
    }
    return itemIDDetails;
  }

// Seperate Order Item Quantities

*/

/*
  static List<dynamic> separateOrderItemQuantities(productIds) {
    List<String> userCartList = List<String>.from(productIds);
    print("U");
    print(userCartList.length);
    dynamic itemQuantity = [];
    List<String> customList = separteOrderProductIdList(productIds);
    print("Customer");
    print(customList.length);
    List<ProductModel> filteredProducts = [];
    print("All");
    print(allProductList.length);
    for (String itemId in customList) {
      List<ProductModel> matchProductList = allProductList
          .where((ProductModel product) => product.productId == itemId)
          .toList();

      if (matchProductList.isNotEmpty) {
        filteredProducts.addAll(matchProductList);
        print("Filer");
        print(filteredProducts.length);
      }
    }
    print(filteredProducts.length);
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
    print(itemQuantity);
    return itemQuantity;
  }
*/
// Seperate Order Product ID List
  static List<String> separteOrderProductIdList(List<dynamic> productIds) {
    return [for (var item in productIds.skip(1)) item.toString().split(":")[0]];
  }

  static List<int> separateOrderItemQuantities(List<dynamic> productIds) {
    List<String> listProductIds = List<String>.from(productIds);
    return [
      for (var item in listProductIds.skip(1))
        int.parse(item.toString().split(":")[2])
    ];
  }

/*
// Seperate Order Item Quantites
  static List<dynamic> separateOrderItemQuantities(List<dynamic> productIds) {
    List<String> productIDList = separteOrderProductIdList(productIds);
    List<ProductModel> filteredProducts = [];

    for (String productID in productIDList) {
      filteredProducts.addAll(allProductList
          .where((productModel) => productModel.productId == productID));
    }

    return [
      for (var item in productIds.skip(1))
        if (filteredProducts.any(
            (productModel) => productModel.productId == item.split(":")[0]))
          int.parse(item.split(":")[2])
    ];
  }
  */
}
