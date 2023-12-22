import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/service/provider/totalamountprovider.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
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
    Textstyle textstyle = Textstyle(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryScreen(
                orderId: widget.orderId,
                seperateQuantilies: widget.seperateQuantilies,
              ),
            ));
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        shadowColor: black,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount * 120,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              ProductModel model = ProductModel.fromMap(
                  widget.data[index].data() as Map<String, dynamic>);
              return Container(
                height: 110,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 95,
                          width: 140,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: cardImageBg,
                              borderRadius: BorderRadius.circular(5)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FancyShimmerImage(
                              height: 120,
                              boxFit: BoxFit.contain,
                              imageUrl: model.productimage![0],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
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
                        padding: const EdgeInsets.only(
                            left: 20, right: 12, top: 15, bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                model.productname!,
                                style: textstyle.largestText
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(model.productunit!.toString(),
                                    style: textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).hintColor,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${widget.seperateQuantilies[index]} * ",
                                        style: textstyle.mediumText600
                                            .copyWith(color: greenColor)),
                                    Text(
                                        "${globalMethod.productPrice(model.productprice!, model.discount!.toDouble())}",
                                        style: textstyle.mediumText600.copyWith(
                                            letterSpacing: 1.2,
                                            color: greenColor)),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                    "= ৳. ${globalMethod.productPrice(model.productprice!, model.discount!.toDouble()) * widget.seperateQuantilies[index]}",
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
            },
          ),
        ),
      ),
    );
  }
}
