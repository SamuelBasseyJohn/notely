import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButton extends StatelessWidget {
  Icon icon;
  final void Function()? onpressed;
  MyButton({
    Key? key,
    this.onpressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onpressed,
      icon: icon,
      color: HexColor("000000"),
    );
  }
}
