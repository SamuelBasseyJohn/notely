import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Widgets/buttons.dart';
import '../Widgets/drawer.dart';
import '../Widgets/text.dart';
import 'note_taking_page.dart';

class SavedNotes extends StatefulWidget {
  const SavedNotes({Key? key}) : super(key: key);

  @override
  State<SavedNotes> createState() => _SavedNotesState();
}

class _SavedNotesState extends State<SavedNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: HexColor("FFFFFF"),
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
            input: "Notely",
            fontSize: 32,
            fontFamily: "Nuntino-SemiBold",
          ),
        ),
        actions: [
          MyButton(
              icon: const Icon(
            Icons.search,
            color: Colors.black,
          )),
          MyButton(
              icon: const Icon(
            Icons.settings,
            color: Colors.black,
          )),
          const SizedBox(
            width: 21,
          ),
        ],
        //Font to use, SemiBold, regular,
      ),
      body: ListView.builder(
          itemCount: 1,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              title: MyText(input: "First Note", fontSize: 20),
            );
          }),

      //Column(
      //   // mainAxisSize: MainAxisSize.max,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteTakingPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 38,
        ),
        elevation: 15,
        backgroundColor: HexColor("37474F"),
      ),
    );
  }
}
