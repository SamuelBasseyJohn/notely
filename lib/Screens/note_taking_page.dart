import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_notes_app/Screens/saved_notes.dart';
import 'package:simple_notes_app/Widgets/buttons.dart';

import '../Widgets/text.dart';

class NoteTakingPage extends StatefulWidget {
  const NoteTakingPage({Key? key}) : super(key: key);

  @override
  State<NoteTakingPage> createState() => _NoteTakingPageState();
}

class _NoteTakingPageState extends State<NoteTakingPage> {
  final TextEditingController _note = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: HexColor("FFFFFF"),
        appBar: AppBar(
          title: TextFormField(
            // validator: ,
            controller: _title,
            style: TextStyle(fontSize: 30, color: HexColor("000000")),
            decoration: InputDecoration(
              hintText: "Title...",
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 30,
              ),
            ),
            onSaved: (value) {},
          ),
          backgroundColor: HexColor("FFFFFF"),
          elevation: 2,
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => SavedNotes())),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),

          actions: [
            MyButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            MyButton(
              icon: const Icon(
                Icons.star_border_rounded,
                color: Colors.black,
              ),
            ),
            MyButton(
                icon: const Icon(
                  Icons.save_as_outlined,
                ),
                onpressed: () {
                  print("hello");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SavedNotes()));
                }),
            const SizedBox(
              width: 21,
            ),
          ],
          //Font to use, SemiBold, regular,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                minLines: 3,
                maxLines: 10000000000000,
                // validator: ,
                controller: _note,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 20, color: HexColor("000000")),
                  border: InputBorder.none,
                  hintText: "Type something...",
                ),
                onSaved: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
