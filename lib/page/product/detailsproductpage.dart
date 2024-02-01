import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/approutes.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../const/utils.dart';

import '../../const/const.dart';
import '../../service/database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../widget/custom_show_dialog_widget.dart';
import '../home/addproductpage.dart';
import 'details_card_swiper.dart';
import 'list_similer_product_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage(
      {super.key, required this.productModel, this.isDelivery = false});
  final ProductModel productModel;

  final bool? isDelivery;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

ProductSelect selectMenu = ProductSelect.detele;

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void didChangeDependencies() {
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  Container _selectPoupMenuButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: greenColor, shape: BoxShape.circle),
      child: PopupMenuButton<ProductSelect>(
        color: Theme.of(context).cardColor,
        onSelected: (ProductSelect product) {
          if (product.name == "detele") {
            showDialog(
              context: context,
              builder: (context) => CustomDialogWidget(
                  title: "Are You want to Delete",
                  content:
                      "Do you Want to Delete The Product Produc. If you delete the Product it can not be undo",
                  onOkayPressed: () async {
                    try {
                      await FirebaseDatabase.deleteProductSnapshot(
                              productId: widget.productModel.productId!)
                          .then((value) {
                        Navigator.pushNamed(context, AppRouters.mainPage);
                        globalMethod.flutterToast(msg: "Delete Succesffully");
                      });
                    } catch (error) {
                      globalMethod.flutterToast(
                          msg: "An Error Occured: $error");
                    }
                  }),
            );
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductPage(
                      isUpdate: true, productModel: widget.productModel),
                ));
          }
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem<ProductSelect>>[
            PopupMenuItem(
              value: ProductSelect.detele,
              child: Text(
                "Delete",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
            PopupMenuItem(
                value: ProductSelect.edit,
                child: Text(
                  "Edit",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )),
          ];
        },
      ),
    );
  }

  Widget buildCircle(
      double leftandRight, double top, double diameter, Color color) {
    return Positioned(
      left: leftandRight,
      right: leftandRight,
      top: top,
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    Utils utils = Utils(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          widget.isDelivery!
              ? Navigator.pop(context)
              : Navigator.pushNamed(context, AppRouters.mainPage, arguments: 1);

          return Future.value(true);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mq.height * .012,
              ),
              SizedBox(
                height: mq.height * .47,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    buildCircle(-mq.height * .26, -mq.height * .7,
                        mq.height * 1.2, utils.green100),
                    buildCircle(-mq.height * .12, -mq.height * .32,
                        mq.height * .67, utils.green200),
                    buildCircle(
                        0, -mq.height * .425, mq.height * .95, utils.green300),
                    Positioned(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: mq.width * .044),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: mq.height * .012,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    widget.isDelivery!
                                        ? Navigator.pop(context)
                                        : Navigator.pushNamed(
                                            context, AppRouters.mainPage,
                                            arguments: 1);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: greenColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                _selectPoupMenuButton(context)
                              ],
                            ),
                            DetailsSwiperWidget(
                                productModel: widget.productModel),
                            SizedBox(
                              height: mq.height * .018,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width * .044),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.productModel.productname!,
                        style: textstyle.largestText.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          letterSpacing: 1.2,
                        )),
                    SizedBox(
                      height: mq.height * .018,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "৳. ${globalMethod.discountedPrice(widget.productModel.productprice!, widget.productModel.discount!.toDouble())}",
                          style: GoogleFonts.abrilFatface(
                              color: greenColor,
                              fontSize: 16,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: mq.width * .012,
                        ),
                        Text(
                          "${widget.productModel.productunit}",
                          style: GoogleFonts.abrilFatface(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              "Discount: ${(widget.productModel.discount!)}%",
                              style: GoogleFonts.poppins(
                                  color: red,
                                  letterSpacing: 1.2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: mq.width * .027,
                            ),
                            Text(
                              "${(widget.productModel.productprice!)}",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.lineThrough,
                                  color: red,
                                  letterSpacing: 1.2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mq.height * .018,
                    ),
                    Text(
                      widget.productModel.productdescription!,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: mq.height * .024,
                    ),
                    if (!widget.isDelivery!)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Similar Products",
                            style: GoogleFonts.abrilFatface(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: mq.height * .012,
                          ),
                          ListSimilerProductWidget(
                              productModel: widget.productModel),
                        ],
                      ),
                    SizedBox(
                      height: mq.height * .024,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
