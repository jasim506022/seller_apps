import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/model/productsmodel.dart';

import '../widget/loadingproductwidget.dart';
import '../widget/productwidget.dart';

const List<String> categorylist = <String>[
  "All",
  'Fruits',
  'Vegetables',
  'Dairy & Egg',
  'Dry & Canned',
  "Drinks",
  "Meat & Fish",
  "Candy & Chocolate"
];

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  String dropdownValue = categorylist.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Products"),
      ),
      body: Column(
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(
              fillColor: const Color(0xfff2f2f8),
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            value: dropdownValue,
            isExpanded: true,
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
            focusColor: Colors.black,
            elevation: 16,
            items: categorylist.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: dropdownValue == "All"
                  ? FirebaseFirestore.instance
                      .collection("seller")
                      .doc(sharedPreference!.getString("uid"))
                      .collection("products")
                      .orderBy("publishDate", descending: true)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("seller")
                      .doc(sharedPreference!.getString("uid"))
                      .collection("products")
                      .where("productcategory", isEqualTo: dropdownValue)
                      .orderBy("publishDate", descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                      return ArticlesShimmerEffectWidget();
                    },
                  );
                }
                return Text("No Text");
              },
            ),
          ),
        ],
      ),
    );
  }
}
