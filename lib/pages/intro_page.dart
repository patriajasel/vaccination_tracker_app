import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vaccination_tracker_app/pages/intro_screens/intro_page_1.dart';
import 'package:vaccination_tracker_app/pages/intro_screens/intro_page_2.dart';
import 'package:vaccination_tracker_app/pages/intro_screens/intro_page_3.dart';
import 'package:vaccination_tracker_app/pages/intro_screens/intro_page_4.dart';
import 'package:vaccination_tracker_app/pages/start_page.dart';
import 'package:vaccination_tracker_app/utils/text_style.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  // Controller for tracking the current page
  final PageController _pageController = PageController();

  int _currentPage = 0; // Track the current page index

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
                IntroPage4()
              ],
            ),
            Container(
                alignment: const Alignment(0.0, 0.7),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                )),
            Container(
              alignment: const Alignment(0.0, 0.9),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_currentPage == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartPage()));
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth * 0.75, screenHeight * 0.05),
                    backgroundColor: Colors.blue.shade700),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_currentPage == 0 ? "Get Started" : "Continue",
                        style: TextStyles().elevatedButton),
                    SizedBox(width: screenWidth * 0.02),
                    const Icon(
                      Icons.east,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
