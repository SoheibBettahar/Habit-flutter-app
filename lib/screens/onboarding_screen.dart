import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/utils/constants.dart';
import 'package:habit/utils/utils.dart';
import 'package:habit/widgets/onboarding_page_widget.dart';

import 'home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          OnBoardingPageWidget(
            page: onBoardingPages[0],
            onPressed: () {
              pageController.animateToPage(1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
            },
          ),
          OnBoardingPageWidget(
            page: onBoardingPages[1],
            onPressed: () {
              pageController.animateToPage(2,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
            },
          ),
          OnBoardingPageWidget(
            page: onBoardingPages[2],
            buttonText: START,
            onPressed: () async {
              // open homeScreen
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              setFirstTime();
            },
          ),
        ],
      ),
    );
  }
}
