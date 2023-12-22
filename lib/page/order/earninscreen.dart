import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_apps/const/global.dart';

class EarningScrren extends StatefulWidget {
  const EarningScrren({super.key});

  @override
  State<EarningScrren> createState() => _EarningScrrenState();
}

class _EarningScrrenState extends State<EarningScrren> {
  double totalEarn = 0.0;

  readTotalEarn() {
    FirebaseFirestore.instance
        .collection("seller")
        .doc(sharedPreference!.getString("uid"))
        .get()
        .then((value) {
      setState(() {
        totalEarn = value.data()!["earnings"];
      });
      print(totalEarn);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readTotalEarn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Text(
              totalEarn.toString(),
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
