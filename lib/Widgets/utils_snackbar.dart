import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(text),
      backgroundColor: HexColor("FA5B3D"),
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
