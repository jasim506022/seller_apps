import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/page/order/single_card_widget.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../model/productsmodel.dart';
import 'deliverypage.dart';

class CartOrderWidget extends StatefulWidget {
  const CartOrderWidget(
      {super.key,
      required this.itemCount,
      required this.data,
      required this.orderId,
      required this.seperateQuantilies});

  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderId;
  final List<dynamic> seperateQuantilies;

  @override
  State<CartOrderWidget> createState() => _CartOrderWidgetState();
}

class _CartOrderWidgetState extends State<CartOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryPage(
                orderId: widget.orderId,
                seperateQuantilies: widget.seperateQuantilies,
              ),
            ));
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 5,
        margin: EdgeInsets.symmetric(
            horizontal: mq.width * .033, vertical: mq.width * .012),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        shadowColor: black,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount * mq.height * .151,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              ProductModel model = ProductModel.fromMap(
                  widget.data[index].data() as Map<String, dynamic>);
              return SingleCardWidget(
                index: index,
                productModel: model,
                seperateQuantilies: widget.seperateQuantilies,
              );
              //return _cardWidget(context, model, textstyle, index);
            },
          ),
        ),
      ),
    );
  }
  /*

  Container _cardWidget(BuildContext context, ProductModel model,
      Textstyle textstyle, int index) {
    return Container(
      height: mq.height * .123,
      width: mq.width * .9,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: mq.height * .112,
                width: mq.width * .31,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: cardImageBg, borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FancyShimmerImage(
                    height: mq.height * .141,
                    boxFit: BoxFit.contain,
                    imageUrl: model.productimage![0],
                  ),
                ),
              ),
              Positioned(
                left: mq.width * .022,
                top: mq.height * .012,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: mq.width * .018, vertical: mq.width * .008),
                  decoration: BoxDecoration(
                    border: Border.all(color: red, width: .5),
                    borderRadius: BorderRadius.circular(15),
                    color: lightred.withOpacity(.2),
                  ),
                  child: Text(
                    "${model.discount}% Off",
                    style: GoogleFonts.poppins(
                      color: red,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: mq.width * .044,
                  right: mq.width * .025,
                  top: mq.height * .019,
                  bottom: mq.height * .019),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      model.productname!,
                      style: textstyle.largestText.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: mq.height * .007),
                  Row(
                    children: [
                      Text(model.productunit!.toString(),
                          style: textstyle.mediumTextbold.copyWith(
                            color: Theme.of(context).hintColor,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: mq.height * .007,
                  ),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${widget.seperateQuantilies[index]} * ",
                              style: textstyle.mediumText600
                                  .copyWith(color: greenColor)),
                          Text(
                              "${globalMethod.discountedPrice(model.productprice!, model.discount!.toDouble())}",
                              style: textstyle.mediumText600.copyWith(
                                  letterSpacing: 1.2, color: greenColor)),
                        ],
                      ),
                      const Spacer(),
                      Text(
                          "= ৳. ${globalMethod.discountedPrice(model.productprice!, model.discount!.toDouble()) * widget.seperateQuantilies[index]}",
                          style: textstyle.mediumTextbold.copyWith(
                            color: greenColor,
                            fontSize: 16,
                            letterSpacing: 1.2,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

*/
}
