import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyText extends StatelessWidget {
  final String input;
  FontWeight weight;
  double fontSize;
  String fontFamily;
  String color;

  MyText(
      {Key? key,
      required this.input,
      this.weight = FontWeight.normal,
      required this.fontSize,
      this.fontFamily = "Nunito-Regular",
      this.color = "000000"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      input,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: weight,
          color: HexColor(color)),
    );
  }
}
