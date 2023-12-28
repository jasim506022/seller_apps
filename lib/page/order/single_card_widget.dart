import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/model/productsmodel.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';

class SingleCardWidget extends StatelessWidget {
  const SingleCardWidget(
      {super.key,
      required this.productModel,
      required this.seperateQuantilies,
      required this.index});
  final ProductModel productModel;
  final List<dynamic> seperateQuantilies;
  final int index;

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
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
                    imageUrl: productModel.productimage![0],
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
                      productModel.productname!,
                      style: textstyle.largestText.copyWith(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: mq.height * .007),
                  Row(
                    children: [
                      Text(productModel.productunit!.toString(),
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
                          Text("${seperateQuantilies[index]} * ",
                              style: textstyle.mediumText600
                                  .copyWith(color: greenColor)),
                          Text(
                              "${globalMethod.discountedPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                              style: textstyle.mediumText600.copyWith(
                                  letterSpacing: 1.2, color: greenColor)),
                        ],
                      ),
                      const Spacer(),
                      Text(
                          "= ৳. ${globalMethod.discountedPrice(productModel.productprice!, productModel.discount!.toDouble()) * seperateQuantilies[index]}",
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
}
