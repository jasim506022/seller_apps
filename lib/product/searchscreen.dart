import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/widget/productwidget.dart';

import '../const/global.dart';
import '../model/productsmodel.dart';
import '../service/provider/searchtextprovider.dart';
import '../widget/loadingproductwidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search Products",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Consumer<SearchTextProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (textEntered) {
                      Provider.of<SearchTextProvider>(context, listen: false)
                          .setDroupValue(selectValue: textEntered);
                      setState(() {});
                      initailizeSearchingProduct(value.searchText);
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff00B761), width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff00B761), width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Search Seller here...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () {
                          initailizeSearchingProduct(value.searchText);
                        },
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: storesDocumentList,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingProductWidget();
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .78,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        ProductModel productModel = ProductModel.fromMap(
                            snapshot.data!.docs[index].data());
                        return ChangeNotifierProvider.value(
                          value: productModel,
                          child: const ProductWidget(),
                        );
                      },
                    );
                  }
                  return const LoadingProductWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
