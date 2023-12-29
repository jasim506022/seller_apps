import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../const/approutes.dart';
import '../../const/const.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';

import '../../const/utils.dart';
import '../../service/database/firebasedatabase.dart';
import '../order/completeorderpage.dart';
import 'addproductpage.dart';
import 'grid_view_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greenColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    return SafeArea(
      child: Scaffold(
        // stack
        body: Stack(
          children: [
            Container(
                height: mq.height,
                width: mq.width,
                color: utils.backgroundCutilsolor),
            //aspectRaation
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                height: mq.height * .33,
                width: mq.width,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)),
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: mq.height,
                width: mq.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: mq.width * .066),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mq.height * .01,
                      ),
                      _buildSellerProfile(context, textstyle),
                      SizedBox(
                        height: mq.height * .01,
                      ),
                      _buildSearchProduct(context),
                      SizedBox(
                        height: mq.height * .018,
                      ),
                      _buildUploadProduct(context, textstyle),
                      SizedBox(
                        height: mq.height * .018,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: mq.width,
                          child: GridView.count(
                            primary: false,
                            crossAxisSpacing: mq.width * .044,
                            mainAxisSpacing: mq.width * .044,
                            childAspectRatio: .95,
                            crossAxisCount: 2,
                            children: [
                              GridViewItem(
                                image: "asset/gridicon/addproduct.png",
                                text: "All Products",
                                function: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouters.mainPage,
                                    arguments: 1,
                                  );
                                },
                              ),
                              GridViewItem(
                                image: "asset/gridicon/sales.png",
                                text: "Total Sales",
                                function: () {
                                  Navigator.pushNamed(
                                      context, AppRouters.totalSales);
                                },
                              ),
                              GridViewItem(
                                image: "asset/gridicon/order.png",
                                text: "Running Order",
                                function: () {
                                  Navigator.pushNamed(
                                      context, AppRouters.orderPage);
                                },
                              ),
                              GridViewItem(
                                image: "asset/gridicon/complete.png",
                                text: "Complete Order",
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CompleteOrderPage(),
                                      ));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildUploadProduct(BuildContext context, Textstyle textstyle) {
    return Container(
      height: mq.height * .2,
      alignment: Alignment.center,
      width: mq.width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductPage(isUpdate: false),
              ));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/additem.png",
              height: mq.height * .085,
              width: mq.height * .085,
              color: greenColor,
            ),
            SizedBox(
              height: mq.height * .012,
            ),
            Text("Upload Your Product", style: textstyle.largestText)
          ],
        ),
      ),
    );
  }

  InkWell _buildSearchProduct(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouters.mainPage,
          arguments: 2,
        );
      },
      child: Container(
        height: mq.height * .065,
        margin: EdgeInsets.symmetric(vertical: mq.width * .033),
        width: mq.width,
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.only(left: mq.width * .066),
          child: Row(
            children: [
              Text(
                "Search...........",
                style: GoogleFonts.roboto(
                  color: Theme.of(context).hintColor,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Icon(
                IconlyLight.search,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: mq.width * .022,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildSellerProfile(BuildContext context, Textstyle textstyle) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouters.mainPage,
          arguments: 3,
        );
      },
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              height: mq.height * 0.08,
              width: mq.height * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * 0.04),
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(
                    backgroundColor: white,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: sharedPreference!.getString("imageurl") ??
                      "asset/empty/blank.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: mq.height * .01,
          ),
          Flexible(
            flex: 6,
            child: FittedBox(
              child: Text(
                  sharedPreference!.getString("name") ??
                      FirebaseDatabase.user.displayName!,
                  style: textstyle.largestText.copyWith(
                    color: white,
                    fontSize: 22,
                  )),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: white,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  size: 25,
                  color: white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
