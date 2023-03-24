import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Widgets/text.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("FFFFFF"),
      child: Stack(
        children: [
          Container(
            alignment: const Alignment(-0.7, -0.7),
            child: MyText(input: "Aesthetic and Intuitive", fontSize: 28),
          ),
          Container(
            alignment: const Alignment(0, -0.13),
            child: const SizedBox(
                height: 400,
                width: 400,
                child: Image(image: AssetImage("Images/Diary-pana.png"))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Container(
              alignment: const Alignment(0, 0.61),
              child: MyText(
                input: "Express your creativity with a clean and simple UI...",
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
