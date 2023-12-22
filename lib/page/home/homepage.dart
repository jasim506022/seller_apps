import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:seller_apps/const/utils.dart';

import '../../const/const.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../completeorder/completecorder.dart';
import '../main/mainscreen.dart';
import '../product/productpage.dart';
import 'addproductpage.dart';
import 'grid_view_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    Textstyle textstyle = Textstyle(context);
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: greenColor,
        // Change the status bar color
        statusBarBrightness: Brightness.light,
        // Change the status bar text color (light or dark)
        statusBarIconBrightness: Brightness.light));
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: mq.height, width: mq.width, color: utils.backgroun),
            Container(
              height: mq.height * .33,
              width: mq.width,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(100)),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: mq.height,
                width: mq.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mq.height * .01,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 3, // Takes 3 parts out of the available space
                            child: SizedBox(
                              height: mq.height * 0.08,
                              width: mq.height * 0.08,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(mq.height *
                                    0.04), // Set border radius for a circular clip
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    backgroundColor: white,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  imageUrl:
                                      sharedPreference!.getString("imageurl")!,
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
                              child: Text(sharedPreference!.getString("name")!,
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
                      const SizedBox(
                        height: 7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(index: 2),
                              ));
                        },
                        child: Container(
                          height: mq.height * .065,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          width: mq.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
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
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: mq.height * .20,
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
                                  builder: (context) =>
                                      AddProductPage(isUpdate: false),
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
                              Text("Upload Your Product",
                                  style: textstyle.largestText.copyWith())
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mq.height * .018,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: mq.width,
                          child: GridView.count(
                            primary: false,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: .95,
                            crossAxisCount: 2,
                            children: [
                              GridViewItem(
                                image: "asset/gridicon/addproduct.png",
                                text: "All Products",
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MainScreen(index: 1),
                                      ));
                                },
                              ),
                              GridViewItem(
                                image: "asset/gridicon/sales.png",
                                text: "Total Sales",
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CompleteOrderPage(),
                                      ));
                                },
                              ),
                              GridViewItem(
                                image: "asset/gridicon/balance.png",
                                text: "Balance",
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductPage(),
                                      ));
                                },
                              ),
                              GridViewItem(
                                image: "asset/gridicon/summary.png",
                                text: "Sales Summary",
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MainScreen(index: 1),
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
}
