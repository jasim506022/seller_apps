import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/page/home/addproductpage.dart';

import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../const/utils.dart';

import '../../const/const.dart';
import '../../database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../main/mainscreen.dart';
import 'details_card_swiper.dart';
import 'loading_similar_widet.dart';
import 'similar_product_widget.dart';

enum ProductSelect { detele, edit }

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

ProductSelect selectMenu = ProductSelect.detele;

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    Utils utils = Utils(context);
    mq = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
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
                  Positioned(
                    left: -mq.height * .35,
                    right: -mq.height * .26,
                    top: mq.height * .47,
                    child: Container(
                      height: mq.height * 1.2,
                      width: mq.height * 1.2,
                      decoration: BoxDecoration(
                          color: utils.green100, //100
                          shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                    left: -mq.height * .12,
                    right: -mq.height * .12,
                    top: -mq.height * .32,
                    child: Container(
                      height: mq.height * .67,
                      width: mq.width * .8,
                      decoration: BoxDecoration(
                          color: utils.green200, //200
                          shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -MediaQuery.of(context).size.width * .425,
                    child: Container(
                      height: MediaQuery.of(context).size.width * .85,
                      width: MediaQuery.of(context).size.width * .85,
                      decoration: BoxDecoration(
                          color: utils.green300, //300
                          shape: BoxShape.circle),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MainScreen(index: 0),
                                      ));
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
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: greenColor, shape: BoxShape.circle),
                                child: PopupMenuButton<ProductSelect>(
                                  color: Theme.of(context).cardColor,
                                  onSelected: (ProductSelect product) {
                                    if (product.name == "detele") {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                Theme.of(context).cardColor,
                                            title: Text(
                                                "Are You want to Delete",
                                                style: GoogleFonts.poppins(
                                                    color: greenColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            content: Text(
                                                "Do you Want to Delete The Product Produc. If you delete the Product it can not be undo",
                                                style: GoogleFonts.poppins(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    try {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("seller")
                                                          .doc(sharedPreference!
                                                              .getString("uid"))
                                                          .collection(
                                                              "products")
                                                          .doc(widget
                                                              .productModel
                                                              .productId)
                                                          .delete()
                                                          .then((value) async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "products")
                                                            .doc(widget
                                                                .productModel
                                                                .productId)
                                                            .delete();
                                                      }).then((value) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MainScreen(),
                                                            ));
                                                        globalMethod.flutterToast(
                                                            msg:
                                                                "Delete Succesffully");
                                                      });
                                                    } catch (error) {
                                                      globalMethod.flutterToast(
                                                          msg:
                                                              "An Error Occured: $error");
                                                    }
                                                  },
                                                  child: const Text("Okay")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No"))
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddProductPage(
                                                    isUpdate: true,
                                                    productModel:
                                                        widget.productModel),
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
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                          value: ProductSelect.edit,
                                          child: Text(
                                            "Edit",
                                            style: GoogleFonts.poppins(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ];
                                  },
                                ),
                              )
                            ],
                          ),
                          DetailsSwiperWidget(
                              productModel: widget.productModel),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        "৳. ${globalMethod.productPrice(widget.productModel.productprice!, widget.productModel.discount!.toDouble())}",
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
                      SizedBox(
                        width: mq.width * .1,
                      ),
                      Text(
                        "Discount: ${(widget.productModel.discount!)}%",
                        style: GoogleFonts.poppins(
                            color: red,
                            letterSpacing: 1.2,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${(widget.productModel.productprice!)}",
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.lineThrough,
                            color: red,
                            letterSpacing: 1.2,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
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
                  SizedBox(
                    height: mq.height * .18,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseDatabase.similarProductSnapshot(
                          productModel: widget.productModel),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingSimilierWidget();
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text(
                            'asset/payment/emptytow.png',
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error Occure: ${snapshot.error}',
                          );
                        }

                        if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ProductModel models = ProductModel.fromMap(
                                    snapshot.data!.docs[index].data());
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsPage(
                                            productModel: models,
                                          ),
                                        ));
                                  },
                                  child: SimilarProductWidget(models: models),
                                );
                              });
                        }
                        return const LoadingSimilierWidget();
                      },
                    ),
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
    );
  }
}
