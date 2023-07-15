import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/global.dart';
import '../model/productsmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String sellerNameText = "";
  Future<QuerySnapshot>? storesDocumentList;

  initailizeSearchingProduct(String textEntereByUser) {
    storesDocumentList = FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreference!.getString("uid"))
        .collection("products")
        .where("productname", isGreaterThanOrEqualTo: textEntereByUser)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (textEntered) {
              setState(() {
                sellerNameText = textEntered;
              });

              initailizeSearchingProduct(sellerNameText);
            },
            decoration: InputDecoration(
              hintText: "Search Seller here...",
              hintStyle: const TextStyle(color: Colors.black),
              suffixIcon: IconButton(
                onPressed: () {
                  initailizeSearchingProduct(sellerNameText);
                },
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: storesDocumentList,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .62,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      ProductModel productModel = ProductModel.fromMap(
                          snapshot.data!.docs[index].data());
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f8).withOpacity(.3),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FancyShimmerImage(
                                height: 120,
                                boxFit: BoxFit.fill,
                                imageUrl: productModel.productimage![0],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              productModel.productname!,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${productModel.productprice!} Tk",
                              style: GoogleFonts.poppins(
                                  color: Color(0xff00b761).withOpacity(.7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xfff2f2f8).withOpacity(.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                productModel.productunit!,
                                style: GoogleFonts.poppins(
                                    color: Color(0xff686874),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xff00b761),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.shop,
                                size: 30,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No record found."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
