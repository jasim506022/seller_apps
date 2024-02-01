import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../const/textstyle.dart';
import '../../model/productsmodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../widget/single_loading_product_widget.dart';
import 'delivery_cart_widget.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    super.key,
    required this.orderDataMap,
    required this.seperateQuantilies,
  });

  final Map<String, dynamic> orderDataMap;
  final List<dynamic> seperateQuantilies;

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: mq.width * .022, vertical: mq.height * .012),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order No: ${orderDataMap["orderId"]}",
            style: textstyle.largeText
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: mq.height * .024),
          Flexible(
            child: FutureBuilder(
              future: FirebaseDatabase.orderDeliveryOrderProductSnapshot(
                  list: orderDataMap['productIds']),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) =>
                        const LoadingSingleProductWidget(),
                  );
                } else if (productSnapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productSnapshot.data!.docs.length,
                    itemBuilder: (context, itemIndex) {
                      ProductModel productModel = ProductModel.fromMap(
                        productSnapshot.data!.docs[itemIndex].data(),
                      );
                      return DeliveryCartWidget(
                        productModel: productModel,
                        itemQunter: seperateQuantilies[itemIndex],
                        index: itemIndex + 1,
                      );
                    },
                  );
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) =>
                      const LoadingSingleProductWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
