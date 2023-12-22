import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/gobalcolor.dart';
import '../../database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../service/provider/searchprovider.dart';
import '../../widget/loading_product_widget.dart';
import '../../widget/product_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductModel> _productList = [];

  TextEditingController searchTEC = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<SearchProvider>(context).setSearch(isSearch: false);
      Provider.of<SearchProvider>(context).clearSearchList();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          return WillPopScope(
            onWillPop: () async {
              if (searchProvider.isSearch) {
                searchProvider.setSearch(isSearch: false);
                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text(
                  "Search Products",
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchTEC,
                        onChanged: (textEntered) {
                          searchProvider.clearSearchList();
                          for (var product in _productList) {
                            if (product.productname!
                                    .toLowerCase()
                                    .contains(textEntered.toLowerCase()) ||
                                product.productcategory!
                                    .toLowerCase()
                                    .contains(textEntered.toLowerCase())) {
                              searchProvider.addProductSearchList(
                                  productModel: product);
                              searchProvider.setSearch(isSearch: true);
                            }
                          }
                        },
                        decoration: inputDecoration(
                            hint: 'Search Here...............',
                            searchProvider: searchProvider),
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseDatabase.searchSellerProductList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LoadingProductWidget();
                          }
                          if (snapshot.hasData) {
                            final productData = snapshot.data!.docs;
                            _productList = productData
                                .map((e) => ProductModel.fromMap(e.data()))
                                .toList();

                            if (_productList.isNotEmpty) {
                              return searchProvider.isSearch &&
                                      searchProvider.searchList.isEmpty
                                  ? Center(
                                      child: Flexible(
                                      child: Image.asset(
                                        "asset/empty/empty.png",
                                      ),
                                    ))
                                  : GridView.builder(
                                      itemCount: searchProvider.isSearch
                                          ? searchProvider.searchList.length
                                          : _productList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: .78,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8),
                                      itemBuilder: (context, index) {
                                        return ChangeNotifierProvider.value(
                                          value: searchProvider.isSearch
                                              ? searchProvider.searchList[index]
                                              : _productList[index],
                                          child: const ProductWidget(),
                                        );
                                      },
                                    );
                            }
                          }

                          return Center(
                              child: Flexible(
                            child: Image.asset(
                              "asset/empty/empty.png",
                            ),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration inputDecoration(
      {required String hint, required SearchProvider searchProvider}) {
    return InputDecoration(
      suffixIcon: IconButton(
          onPressed: () {
            searchProvider.clearSearchList();
            searchProvider.setSearch(isSearch: false);
            searchTEC.text = "";
            FocusScope.of(context).unfocus();
          },
          icon: searchProvider.isSearch
              ? Icon(
                  Icons.close,
                  color: red,
                )
              : Container()),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greenColor, width: 1),
          borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greenColor, width: 1),
          borderRadius: BorderRadius.circular(15)),
      hintText: hint,
      hintStyle: TextStyle(color: grey),
    );
  }
}
