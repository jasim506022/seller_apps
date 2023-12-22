import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/const.dart';
import '../const/gobalcolor.dart';
import '../const/textstyle.dart';
import '../model/productsmodel.dart';
import '../page/home/addproductpage.dart';
import '../page/product/detailsproductpage.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    final productModel = Provider.of<ProductModel>(context);
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
      child: Card(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: white,
                  spreadRadius: .08,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: mq.height * .125,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: cardImageBg,
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: mq.height * .85,
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
                          horizontal: mq.width * .02,
                          vertical: mq.height * .006),
                      decoration: BoxDecoration(
                        border: Border.all(color: red, width: .5),
                        borderRadius: BorderRadius.circular(15),
                        color: lightred.withOpacity(.2),
                      ),
                      child: Text("${productModel.discount}% Off",
                          style: textstyle.mediumText600),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: mq.width * .028),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "৳. ${(productModel.productprice!) - (productModel.productprice! * productModel.discount! / 100)}",
                            style: textstyle.largeText.copyWith(color: red),
                          ),
                          SizedBox(
                            width: mq.height * .016,
                          ),
                          Text(
                            "${(productModel.productprice!)}",
                            style: Textstyle.mediumText400lineThrough,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mq.height * .005,
                      ),
                      FittedBox(
                        child: Text(
                          productModel.productname!,
                          style: textstyle.largeText,
                        ),
                      ),
                      SizedBox(
                        height: mq.height * .005,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductPage(
                                    isUpdate: true, productModel: productModel),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: mq.height * .045,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: greenColor,
                          ),
                          child: Text(
                            "Edit/Update",
                            style: textstyle.largeText
                                .copyWith(color: white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mq.height * .008,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
