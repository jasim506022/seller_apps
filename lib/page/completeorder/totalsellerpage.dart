import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/const/cartmethod.dart';
import 'package:seller_apps/const/gobalcolor.dart';
import 'package:seller_apps/service/provider/totalamountprovider.dart';

import '../order/completeorderpage.dart';

class TotalSellPage extends StatefulWidget {
  const TotalSellPage({super.key});

  @override
  State<TotalSellPage> createState() => _TotalSellPageState();
}

class _TotalSellPageState extends State<TotalSellPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<TotalAmountProvider>(context, listen: false).setZeroAmount();
    });
    CartMethods.allSellMoeny(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      appBar: AppBar(
        title: const Text(
          "Total Earn",
        ),
      ),
      body: Consumer<TotalAmountProvider>(
        builder: (context, value, child) {
          return Center(
              child: Container(
            height: 350,
            width: 350,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tk. ${value.amount}",
                    style: TextStyle(color: Colors.black, fontSize: 50),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompleteOrderPage(),
                          ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Details",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )

              //  Text(
              //   "${value.amount}",
              //   style: TextStyle(color: Colors.black, fontSize: 50),
              // ),
              );
        },
      ),
    );
  }
}
