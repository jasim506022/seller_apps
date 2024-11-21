import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/view/product/loading_similar_widet.dart';

import '../../const/global.dart';
import '../../res/apps_color.dart';
import '../../res/routes/routes_name.dart';
import '../../const/utils.dart';

import '../../model/productsmodel.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var productController = Get.find<ProductController>();
  late ProductModel productModel;

  @override
  void initState() {
    var arguments = Get.arguments;
    productModel = arguments["productModel"];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Utils utils = Utils(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          Get.offAndToNamed(RoutesName.mainPage);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              DetailsPageImageSlideWithCartBridgeWidget(
                productModel: productModel,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductAllDetails(productModel, productController),
                    Text(
                      "StringConstant.similarProducts",
                      style: AppsTextStyle.titleTextStyle,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SimilarProductList(
                      productModel: productModel,
                    ),
                    const SizedBox(
                      height: 20,
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

  Column _buildProductAllDetails(
      ProductModel productModel, ProductController productController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel.productname!,
            style: AppsTextStyle.largeBoldText.copyWith(fontSize: 20.sp)),
        SizedBox(
          height: 15.h,
        ),
        /*
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                style: AppsTextStyle.titleTextStyle.copyWith(color: AppColors.red)),
            SizedBox(
              width: 10.w,
            ),
            Text("${productModel.productunit}",
                style: AppsTextStyle.smallBoldText),
            SizedBox(
              width: 50.h,
            ),
            Text(
              "Discount: ${(productModel.discount!)}%",
              style: AppsTextStyle.titleTextStyle.copyWith(color: AppColors.red),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              "${(productModel.productprice!)}",
              style: AppsTextStyle.titleTextStyle.copyWith(color: AppColors.red)
                  .copyWith(decoration: TextDecoration.lineThrough),
            ),
          ],
        ),
        */
        SizedBox(
          height: 15.h,
        ),
        Text(productModel.productdescription!,
            textAlign: TextAlign.justify,
            style: AppsTextStyle.mediumNormalText),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            // Obx(
            //   () => Text(
            //       "৳. ${AppsFunction.productPriceWithQuantity(productModel.productprice!, productModel.discount!.toDouble(), productController.productItemQuantity.value).toStringAsFixed(2)}",
            //       style: AppsTextStyle.largeBoldRedText
            //           .copyWith(color: AppColors.greenColor)),
            // ),
            SizedBox(
              width: 20.w,
            ),
/*
            Row(
              children: [
                _buildIncreandDecrementButton(() {
                  productController.updateQuantity();
                }, Icons.add),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Obx(() => Text(
                      productController.productItemQuantity.value.toString(),
                      style: AppsTextStyle.largestText)),
                ),

                //Increament Button
                _buildIncreandDecrementButton(
                  () {
                    productController.updateQuantity(isIncrement: false);
                  },
                  Icons.remove,
                ),
              ],
            ),
*/
            const Spacer(),
            // Rattting Product
            Row(
              children: [
                Icon(Icons.star, color: AppColors.yellow),
                RichText(
                  text: TextSpan(
                      style: AppsTextStyle.rattingText.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                      children: [
                        const TextSpan(text: "( "),
                        TextSpan(text: "${productModel.productrating!}"),
                        TextSpan(
                            text: " ${"StringConstant.rattings"} ",
                            style: AppsTextStyle.rattingText),
                        TextSpan(
                            text: ")",
                            style: AppsTextStyle.rattingText.copyWith(
                              color: Theme.of(context).primaryColor,
                            )),
                      ]),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class DetailsPageImageSlideWithCartBridgeWidget extends StatelessWidget {
  const DetailsPageImageSlideWithCartBridgeWidget({
    super.key,
    required this.productModel,
    this.backCart = false,
  });

  final ProductModel productModel;
  final bool backCart;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return SizedBox(
      height: 320.h,
      width: 1.sw,
      child: Stack(
        children: [
          //understand this code carefully
          for (Map<String, dynamic> circleConfig in [
            {
              'left': -300.00.w,
              'right': -300.00.w,
              'top': -350.00.h,
              'size': 650.00.h,
              'color': utils.green100
            },
            {
              'left': -80.00.w,
              'right': -80.00.w,
              'top': -360.00.h,
              'size': 650.00.h,
              'color': utils.green200
            },
            {
              'left': 0.00,
              'right': 0.00,
              'top': -150.00.w,
              'size': 300.00.h,
              'color': utils.green300
            },
          ])
            Positioned(
              left: circleConfig['left'],
              right: circleConfig['right'],
              top: circleConfig['top'],
              child: Container(
                height: circleConfig['size'],
                width: circleConfig['size'],
                decoration: BoxDecoration(
                  color: circleConfig['color'],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: _buildCircularButton(
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            // if (!(await AppsFunction.verifyInternetStatus())) {
                            //   Get.toNamed(RoutesName.cartPage);
                            // }
                          },
                          child: _buildCircularButton(
                            Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: 25,
                            ),
                          ))
                    ],
                  ),
                  DetailsImageSwiperWidget(productModel: productModel),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCircularButton(Widget widget) {
    return Container(
        height: 50.h,
        width: 50.h,
        decoration:
            BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle),
        child: widget);
  }
}

class DetailsImageSwiperWidget extends StatelessWidget {
  const DetailsImageSwiperWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 200.h,
        width: .9.sw,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: productModel.productimage![index],
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
          autoplay: productModel.productimage!.length == 1 ? false : true,
          itemCount: productModel.productimage!.length,
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  color: AppColors.white, activeColor: AppColors.red)),
          control: const SwiperControl(color: Colors.transparent),
        ),
      ),
    );
  }
}

class SimilarProductList extends StatelessWidget {
  const SimilarProductList({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return SizedBox(
      height: 150.h,
      width: Get.width,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("seller")
            .doc(sharedPreference!.getString("uid")!)
            .collection("products")
            .where("productId", isNotEqualTo: productModel.productId)
            .where("productcategory", isEqualTo: productModel.productcategory)
            .snapshots(),
        // productController.similarProductSnapshot(
        //     productModel: productModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
          } else if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty ||
              snapshot.hasError) {
            // return SingleEmptyWidget(
            //   image: ImagesAsset.errorSingle,
            //   title: snapshot.hasError
            //       ? 'Error Occure: ${snapshot.error}'
            //       : 'No Data Available',
            // );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length > 5
                    ? 5
                    : snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ProductModel productModel =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
                  return ChangeNotifierProvider.value(
                    value: productModel,
                    child: SimilarProductWidget(
                        // isCartBack: isCart,
                        ),
                  );
                });
          }
          return const LoadingSimilierWidget();
        },
      ),
    );
  }
}

class SimilarProductWidget extends StatelessWidget {
  const SimilarProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    // bool isCart =
    //     CartFunctions.separateProductID().contains(productModel.productId);
    return InkWell(
      onTap: () async {
        if (!(await AppsFunction.verifyInternetStatus())) {
          // Get.offAndToNamed(
          //   RoutesName.productDestailsPage,
          //   arguments: {"productModel": productModel, "isCart": isCartBack},
          // );
        }
      },
      child: Container(
        height: 150.h,
        width: 100.w,
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.only(left: 15.w),
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: FancyShimmerImage(
                height: 80.h,
                boxFit: BoxFit.fill,
                imageUrl: productModel.productimage![0],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            FittedBox(
                child: Text(productModel.productname!,
                    textAlign: TextAlign.justify,
                    style: AppsTextStyle.rattingText
                        .copyWith(color: Theme.of(context).primaryColor))),
          ],
        ),
      ),
    );
  }
}

/*
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
                        Navigator.pushNamed(context, RoutesName.mainPage);
                        globalMethod.flutterToast(msg: "Delete Succesffully");
                      });
                    } catch (error) {
                      globalMethod.flutterToast(
                          msg: "An Error Occured: $error");
                    }
                  }),
            );
          } else {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => AddProductPage(
            //           isUpdate: true, productModel: widget.productModel),
            //     ));
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
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          widget.isDelivery!
              ? Navigator.pop(context)
              : Navigator.pushNamed(context, RoutesName.mainPage, arguments: 1);

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
                                            context, RoutesName.mainPage,
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
                          "৳. ${globalMethod.discountedPrice(widget.productModel.productprice!.toDouble(), widget.productModel.discount!.toDouble())}",
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

*/