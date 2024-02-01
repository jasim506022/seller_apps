import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../model/productsmodel.dart';
import 'detailsproductpage.dart';

class SimilarProductWidget extends StatelessWidget {
  const SimilarProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        height: mq.height * .18,
        width: mq.width * .3,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(left: mq.width * .034),
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FancyShimmerImage(
                height: mq.height * .118,
                boxFit: BoxFit.fill,
                imageUrl: productModel.productimage![0],
              ),
            ),
            SizedBox(
              height: mq.height * .012,
            ),
            FittedBox(
              child: Text(
                productModel.productname!,
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
