import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_notes_app/Screens/note_taking_page.dart';

import 'package:simple_notes_app/Widgets/buttons.dart';
import 'package:simple_notes_app/Widgets/drawer.dart';
import 'package:simple_notes_app/Widgets/text.dart';
import 'package:introduction_screen/introduction_screen.dart';

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({Key? key}) : super(key: key);

  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: HexColor("FFFFFF"),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: HexColor("FFFFFF"),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Icon(
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
            input: "Notely",
            fontSize: 32,
            fontFamily: "Nuntino-SemiBold",
          ),
        ),
        actions: [
          MyButton(
              icon: Icon(
            Icons.search,
            color: Colors.black,
          )),
          MyButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 21,
          ),
        ],
        //Font to use, SemiBold, regular,
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("Images/Add-notes-pana.png")),
          SizedBox(
            height: 10,
          ),
          MyText(input: "Create your first note!", fontSize: 20),
          SizedBox(
            height: 50,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteTakingPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 38,
        ),
        elevation: 15,
        backgroundColor: HexColor("37474F"),
      ),
    );
  }
}
