import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyText extends StatelessWidget {
  final String input;
  FontWeight weight;
  double fontSize;
  TextOverflow? overflow;
  String color;
  int? maxLines;

  MyText(
      {Key? key,
      this.maxLines,
      this.overflow,
      required this.input,
      this.weight = FontWeight.normal,
      required this.fontSize,
      this.color = "000000"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      input,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          fontSize: fontSize, fontWeight: weight, color: HexColor(color)),
    );
  }
}
