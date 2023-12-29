import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/cartmethod.dart';
import '../../const/const.dart';
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
    CartMethods.allSellMoeny(context);
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
            height: mq.height * .42,
            width: mq.height * .42,
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
                    height: mq.height * 0.02,
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
                          horizontal: mq.width * .088,
                          vertical: mq.height * .015),
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
