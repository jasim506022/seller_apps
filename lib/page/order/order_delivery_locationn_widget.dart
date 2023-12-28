import 'package:flutter/material.dart';
import 'package:seller_apps/const/const.dart';

import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../service/database/firebasedatabase.dart';

class OrderDeliveryLocationWidget extends StatelessWidget {
  const OrderDeliveryLocationWidget({
    super.key,
    required this.userId,
    required this.orderStatus,
    required this.orderDataMap,
  });

  final String userId;
  final String orderStatus;
  final Map<String, dynamic> orderDataMap;
  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Column(
      children: [
        Container(
          width: mq.width,
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * .011, vertical: mq.height * .011),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Delivery Address: ",
                  style: textstyle.mediumTextbold
                      .copyWith(color: Theme.of(context).primaryColor)),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseDatabase.userDeliverysnapshot(
                        addressId: orderDataMap['addressId'], userId: userId),
                    builder: (context, addressSnashot) {
                      if (addressSnashot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (addressSnashot.hasData) {
                        return Text(
                            addressSnashot.data!.data()!['completeaddress'],
                            style: textstyle.mediumText);
                      }
                      return const Text("Address Not Found");
                    }),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mq.height * .018,
        ),
        Container(
          decoration: BoxDecoration(
              color: deepGreen, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(
            horizontal: mq.height * .012,
            vertical: mq.width * 0.022,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Estimated Delivery Date is: ",
                  style: textstyle.largeText.copyWith(
                    color: white,
                    fontSize: 15,
                  )),
              SizedBox(
                width: mq.width * .044,
              ),
              Text(
                orderStatus == "complete"
                    ? "Order Compete"
                    : globalMethod.getFormateDate(
                        context: context,
                        datetime: orderDataMap["deliverydate"]),
                style:
                    textstyle.largestText.copyWith(color: white, fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mq.height * .018,
        ),
        Container(
          width: mq.width,
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Text("Delivery Partner: ${orderDataMap["deliverypartner"]}",
              style: textstyle.mediumText600
                  .copyWith(color: Theme.of(context).primaryColor)),
        ),
        SizedBox(
          height: mq.height * .018,
        ),
      ],
    );
  }
}
