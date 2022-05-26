import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_notes_app/Widgets/drawer.dart';

import '../Widgets/buttons.dart';
import '../Widgets/text.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFFFFF"),
      drawer: const MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: HexColor("FFFFFF"),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        // leading: IconButton(
        //   onPressed: (() {
        //     // _globalKey.currentState?.openDrawer();
        //   }),
        //   icon: Icon(Icons.menu),
        //   color: HexColor("000000"),
        // ),
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyText(
            input: "Favorites",
            fontSize: 32,
            fontFamily: "Nuntino-SemiBold",
          ),
        ),
        actions: [
          MyButton(icon: const Icon(Icons.search)),
          MyButton(icon: const Icon(Icons.delete)),
          const SizedBox(
            width: 21,
          ),
        ],
        //Font to use, SemiBold, regular,
      ),
    );
  }
}
