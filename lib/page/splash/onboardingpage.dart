import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/approutes.dart';
import '../../const/const.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/onboardmodel.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> onBoardingInfo() async {
    int isViewed = 0;
    await sharedPreference!.setInt("onBoarding", isViewed);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: white, statusBarIconBrightness: Brightness.dark));
    Textstyle textstyle = Textstyle(context);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                onBoardingInfo();
                Navigator.pushReplacementNamed(context, AppRouters.signPage);
              },
              child: Text(
                "Skip",
                style: textstyle.largestText.copyWith(color: black),
              )),
          SizedBox(
            width: mq.width * .022,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.height * .044),
        child: PageView.builder(
          controller: _pageController,
          itemCount: onboardModeList.length,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  onboardModeList[index].img,
                  height: mq.height * .411,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: mq.height * .013,
                  child: ListView.builder(
                    itemCount: onboardModeList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: mq.height * .01,
                            width: mq.height * .01,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                                color: currentIndex == index ? red : brown,
                                borderRadius:
                                    BorderRadius.circular(mq.height * .01)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  onboardModeList[index].text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 30, fontWeight: FontWeight.bold, color: black),
                ),
                Text(onboardModeList[index].desc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: black)),
                InkWell(
                  onTap: () async {
                    if (index == onboardModeList.length - 1) {
                      await onBoardingInfo();
                      if (mounted) {
                        Navigator.pushReplacementNamed(
                            context, AppRouters.signPage);
                      }
                    }
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.bounceIn);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * .066,
                        vertical: mq.height * .015),
                    decoration: BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.circular(mq.width * .033)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next",
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                        SizedBox(
                          width: mq.width * .04,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
