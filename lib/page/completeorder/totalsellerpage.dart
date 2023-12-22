import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/const/cartmethod.dart';
import 'package:seller_apps/service/provider/totalamountprovider.dart';

class TotalSellPage extends StatefulWidget {
  const TotalSellPage({super.key});

  @override
  State<TotalSellPage> createState() => _TotalSellPageState();
}

class _TotalSellPageState extends State<TotalSellPage> {
  @override
  void initState() {
    // TODO: implement initState
    CartMethods.allSellMoeny(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TotalAmountProvider>(
        builder: (context, value, child) {
          return Text(
            "${value.amount}",
            style: TextStyle(color: Colors.black, fontSize: 50),
          );
        },
      ),
    );
  }
}
