import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Widgets/buttons.dart';

class NoteEditingPage extends StatefulWidget {
  const NoteEditingPage({Key? key}) : super(key: key);

  @override
  State<NoteEditingPage> createState() => _NoteEditingPageState();
}

class _NoteEditingPageState extends State<NoteEditingPage> {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("notes");
  String title = '';
  String description = '';
  final TextEditingController controllerBody = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: HexColor("FFFFFF"),
        appBar: AppBar(
          title: TextFormField(
            // validator: ,
            controller: controllerTitle,
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
            style: TextStyle(fontSize: 27, color: HexColor("000000")),
            decoration: const InputDecoration(
              hintText: "Title...",
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 27,
              ),
            ),
            onSaved: (value) {},
          ),
          backgroundColor: HexColor("FFFFFF"),
          elevation: 2,
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
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
                  // createNote(title: title);
                  Navigator.pop(context);
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const SavedNotes()));
                  // reference.add(
                  //     {"title": title.text, "body": note.text}).whenComplete(
                  //   () => Navigator.pop(
                  //     context,
                  //     // MaterialPageRoute(
                  //     //   builder: (context) => const SavedNotes(),
                  //     // ),
                  //   ),
                  // );
                  // print("hello");
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const SavedNotes()));
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
                style: TextStyle(fontSize: 20, color: HexColor("000000")),
                maxLines: null,
                // validator: ,
                controller: controllerBody,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                expands: false,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
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
