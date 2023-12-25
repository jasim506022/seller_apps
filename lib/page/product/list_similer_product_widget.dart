import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../model/productsmodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../widget/empty_widget.dart';

import 'loading_similar_widet.dart';
import 'similar_product_widget.dart';

class ListSimilerProductWidget extends StatelessWidget {
  const ListSimilerProductWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mq.height * .18,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream:
            FirebaseDatabase.similarProductSnapshot(productModel: productModel),
        builder: (context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingSimilierWidget();
            } else if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ProductModel models =
                        ProductModel.fromMap(snapshot.data!.docs[index].data());
                    return ChangeNotifierProvider.value(
                      value: models,
                      child: const SimilarProductWidget(),
                    );
                  });
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
            return const LoadingSimilierWidget();
          } catch (error) {
            return EmptyWidget(
              image: 'asset/empty/empty.png',
              title: 'An Error Occured: $error',
            );
          }
/*

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
                  ProductModel models =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              productModel: models,
                            ),
                          ));
                    },
                    child: SimilarProductWidget(models: models),
                  );
                });
          }
          return const LoadingSimilierWidget();
*/
        },
      ),
    );
  }
}
