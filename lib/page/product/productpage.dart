import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';

import '../../const/global.dart';
import '../../service/database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../service/provider/dropvalueselectallprovider.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_product_widget.dart';
import '../../widget/product_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<CateoryDropValueProvider>(context, listen: false)
          .setDroupValue(selectValue: allCategoryList.first);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Products",
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Consumer<CateoryDropValueProvider>(
              builder: (context, dropvaluesall, child) {
                return DropdownButtonFormField(
                  decoration:
                      globalMethod.decorationDropDownButtonForm(context),
                  value: dropvaluesall.cateoryDropValue,
                  isExpanded: true,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  focusColor: Theme.of(context).primaryColor,
                  elevation: 16,
                  iconEnabledColor: Theme.of(context).primaryColor,
                  items: allCategoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                    Provider.of<CateoryDropValueProvider>(context,
                            listen: false)
                        .setDroupValue(selectValue: value!);
                  },
                );
              },
            ),
            Expanded(
              child: Consumer<CateoryDropValueProvider>(
                builder: (context, cateoryDropValueProvider, child) {
                  return StreamBuilder(
                    stream: FirebaseDatabase.allProductListSnapshots(
                        category: cateoryDropValueProvider.cateoryDropValue),
                    builder: (context, snapshot) {
                      try {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingProductWidget();
                        } else if (snapshot.hasData) {
                          return GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .78,
                                    crossAxisSpacing: mq.width * .009,
                                    mainAxisSpacing: mq.width * .018),
                            itemBuilder: (context, index) {
                              ProductModel productModel = ProductModel.fromMap(
                                  snapshot.data!.docs[index].data());
                              return ChangeNotifierProvider.value(
                                value: productModel,
                                child: const ProductWidget(),
                              );
                            },
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text(
                            'asset/payment/emptytow.png',
                            style: TextStyle(color: Colors.black),
                          );
                        } else if (!snapshot.hasData) {
                          return const EmptyWidget(
                            image: 'asset/empty/empty.png',
                            title: 'No Data Found',
                          );
                        }
                        return const LoadingProductWidget();
                      } catch (error) {
                        return EmptyWidget(
                          image: 'asset/empty/empty.png',
                          title: 'An Error Occured: $error',
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
