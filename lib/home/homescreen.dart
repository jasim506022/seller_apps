import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/main/mainscreen.dart';
import 'package:seller_apps/product/allproduct.dart';

import 'additemscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xfff2f2f8)),
            Container(
              height: MediaQuery.of(context).size.height * .33,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff00b761),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(100)),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                sharedPreference!.getString("imageurl")!),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            sharedPreference!.getString("name")!,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        height: 55,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Color(0xff686874),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Search",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff686874),
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddItemScreen(),
                                ));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "asset/image/additem.png",
                                height: 70,
                                width: 70,
                                color: Color(0xff00b761),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Upload Your Product",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
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
                                        builder: (context) => AllProducts(),
                                      ));
                                },
                                // function: () {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => AllProducts(),);)
                                // },
                              ),
                              GridViewItem(
                                image: "asset/gridicon/sales.png",
                                text: "Total Sales",
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllProducts(),
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
                                        builder: (context) => AllProducts(),
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

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.image,
    required this.text,
    required this.function,
  });
  final String image;
  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 70,
                width: 70,
                color: Color(0xff00b761),
              ),
              SizedBox(
                height: 10,
              ),
              Text(text,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700))
            ],
          )),
    );
  }
}
