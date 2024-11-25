import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../const/cart_function.dart';
import '../../const/gobalcolor.dart';
import '../../service/provider/totalamountprovider.dart';
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
    CartFunctions.allSellMoeny(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Total Earn",
        ),
      ),
      body: Consumer<TotalAmountProvider>(
        builder: (context, value, child) {
          return Center(
              child: Container(
            height: 0.4.sh,
            width: 0.4.sh,
            decoration:
                BoxDecoration(color: greenColor, shape: BoxShape.circle),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tk. ${value.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CompleteOrderPage(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.h, vertical: 15.h),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Details",
                        style: TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
