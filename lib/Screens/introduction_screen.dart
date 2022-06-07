import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
            alignment: const Alignment(0, 0.75),
            child: SmoothPageIndicator(controller: _pageController, count: 3),
          ),
          Container(
            alignment: const Alignment(0, 0.92),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  lastPage
                      ? ElevatedButton(
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SavedNotes(),
                            //   ),
                            // );
                          },
                          child: MyText(
                            input: "Continue Offline",
                            fontSize: 20,
                            color: "252525",
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            primary: HexColor("d6d6d6"),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _pageController.jumpToPage(2);
                          },
                          child: MyText(
                            input: "Skip",
                            fontSize: 20,
                            color: "252525",
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            primary: HexColor("D6D6D6"),
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
