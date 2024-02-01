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
    mq = MediaQuery.of(context).size;
    Textstyle textstyle = Textstyle(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productModel: productModel,
                isDelivery: true,
              ),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mq.width * .022,
          vertical: mq.height * .008,
        ),
        child: Column(
          children: [
            Container(
              height: mq.height * .152,
              width: mq.width * .9,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(
                    mq.width * .044,
                  )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: mq.height * .131,
                        width: mq.width * .311,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(
                          mq.width * .022,
                        ),
                        padding: EdgeInsets.all(
                          mq.width * .022,
                        ),
                        decoration: BoxDecoration(
                            color: cardImageBg,
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            mq.width * .022,
                          ),
                          child: FancyShimmerImage(
                            height: mq.height * .143,
                            boxFit: BoxFit.contain,
                            imageUrl: productModel.productimage![0],
                          ),
                        ),
                      ),
                      Positioned(
                        left: mq.height * .012,
                        top: mq.width * .022,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: mq.width * .028,
                            vertical: mq.height * .007,
                          ),
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
                          right: mq.height * .027,
                          top: mq.height * .018,
                          bottom: mq.height * .018),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(productModel.productname!,
                                style: textstyle.largeBoldText.copyWith(
                                    color: Theme.of(context).primaryColor)),
                          ),
                          SizedBox(
                            height: mq.height * .007,
                          ),
                          Text(
                            productModel.productunit!.toString(),
                            style: textstyle.mediumTextbold
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: mq.height * .007,
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
                                      "${globalMethod.discountedPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                                      style: textstyle.mediumText600
                                          .copyWith(color: greenColor)),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                  "= ৳. ${globalMethod.discountedPrice(productModel.productprice!, productModel.discount!.toDouble()) * itemQunter}",
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
          ],
        ),
      ),
    );
  }
}
