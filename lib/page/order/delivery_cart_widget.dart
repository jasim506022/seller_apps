import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/productsmodel.dart';

import '../product/detailsproductpage.dart';

class DeliveryCartWidget extends StatelessWidget {
  const DeliveryCartWidget({
    super.key,
    required this.productModel,
    required this.itemQunter,
    required this.index,
  });
  final ProductModel productModel;
  final int itemQunter;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool addMoney = false;
    Textstyle textstyle = Textstyle(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productModel: productModel,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Container(
              height: 130,
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
                        height: 110,
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
                            imageUrl: productModel.productimage![0],
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
                            "${productModel.discount}% Off",
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
                            child: Text(productModel.productname!,
                                style: textstyle.largeBoldText.copyWith(
                                    color: Theme.of(context).primaryColor)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            productModel.productunit!.toString(),
                            style: textstyle.mediumTextbold
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${1 * itemQunter} * ",
                                      style: textstyle.mediumText600
                                          .copyWith(color: greenColor)),
                                  Text(
                                      "${globalMethod.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                                      style: textstyle.mediumText600
                                          .copyWith(color: greenColor)),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                  "= ৳. ${globalMethod.productPrice(productModel.productprice!, productModel.discount!.toDouble()) * itemQunter}",
                                  style: textstyle.largeBoldText.copyWith(
                                      color: greenColor, letterSpacing: 1.2)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            // SizedBox(
            //   width: MediaQuery.of(context)
            //       .size
            //       .width, // Adjust the width as needed
            //   child: CustomPaint(
            //     painter: DottedLinePainter(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
