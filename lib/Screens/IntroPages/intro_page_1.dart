import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_notes_app/Widgets/text.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: HexColor("FFFFFF"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 0,
            ),
            MyText(input: "Hello there!", fontSize: 30),
            const Image(
              image: AssetImage(
                "Images/Typing-pana.png",
              ),
            ),
            Center(
              child: MyText(
                input: "Welcome to Notely!",
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        )
        //     Stack(
        //   children: [
        //     Container(
        //       alignment: Alignment(-0.7, -0.7),
        //       child: MyText(input: "Hello there!", fontSize: 30),
        //     ),
        //     Container(
        //       alignment: Alignment(0, -0.15),
        //       child: Image(image: AssetImage("Images/Typing-pana.png")),
        //     ),
        //     Container(
        //       alignment: Alignment(0, 0.47),
        //       child: MyText(
        //         input: "Welcome to Notely!",
        //         fontSize: 30,
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
