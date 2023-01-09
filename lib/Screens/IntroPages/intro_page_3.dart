import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Widgets/text.dart';
import '../Authentication/create_account.dart';
import '../Authentication/sign_in.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("FFFFFF"),
      child: Stack(
        children: [
          Container(
            alignment: const Alignment(0, -0.79),
            child: MyText(
              fontSize: 30,
              input: "Sign Up",
            ),
          ),
          Container(
            alignment: const Alignment(0, -0.13),
            child: const Image(image: AssetImage("Images/Devices-bro.png")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              alignment: const Alignment(0, -0.6),
              child: MyText(
                input: "Access all your notes on multiple devices",
                fontSize: 25,
              ),
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.48),
            child: ElevatedButton(
                onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: HexColor("FA5B3D"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: MyText(
                  input: "Create Account",
                  fontSize: 20,
                )),
          ),
          Container(
            alignment: const Alignment(0, 0.65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(input: "Got an account already?", fontSize: 20.0),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const Login(),
                    ),
                  ),
                  child: MyText(
                    input: "Log in",
                    fontSize: 20,
                    color: "FA5B3D",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
