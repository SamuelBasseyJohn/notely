import 'package:flutter/material.dart';
import 'package:simple_notes_app/Widgets/buttons.dart';
import 'package:simple_notes_app/Widgets/drawer.dart';
import 'package:simple_notes_app/Widgets/text.dart';

class AboutNotely extends StatefulWidget {
  const AboutNotely({Key? key}) : super(key: key);

  @override
  State<AboutNotely> createState() => _AboutNotelyState();
}

class _AboutNotelyState extends State<AboutNotely> {
  // ignore: unused_field
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MyDrawer(),
      // backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: MyButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onpressed: () => Navigator.pop(context),
        ),

        centerTitle: false,

        //Font to use, SemiBold, regular,
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyText(input: 'Notely', fontSize: 50),
          Center(child: Image.asset("Images/Notes-amico.png")),
          const SizedBox(
            height: 10,
          ),
          MyText(input: "Version: 1.0.1", fontSize: 20),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
