import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:simple_notes_app/Screens/IntroPages/intro_page_1.dart';
import 'package:simple_notes_app/Screens/IntroPages/intro_page_2.dart';
import 'package:simple_notes_app/Screens/IntroPages/intro_page_3.dart';
import 'package:simple_notes_app/Widgets/text.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //Page controller to controle the amount of pages we have and the apage we are currently on.
  final PageController _pageController = PageController();

  //Boolean value to handle if we are on the last page or not
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            //This onPageChanged property will tell us the value of the page we are currently on
            onPageChanged: (index) {
              setState(() {
                lastPage = (index == 2);
              });
            },

            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.77),
            child: SizedBox(
              height: 10,
              child: SmoothPageIndicator(
                effect: const SwapEffect(),
                controller: _pageController,
                count: 3,
              ),
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.95),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  lastPage
                      ? MyText(input: " ", fontSize: 30)
                      : TextButton(
                          onPressed: () {
                            _pageController.jumpToPage(2);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyText(
                                input: "Skip",
                                fontSize: 20,
                                color: "252525",
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
