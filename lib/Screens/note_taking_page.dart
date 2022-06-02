import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_notes_app/Screens/saved_notes.dart';
import 'package:simple_notes_app/Widgets/buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_notes_app/main.dart';
import '../Widgets/text.dart';
import 'package:simple_notes_app/Models/note.dart';

class NoteTakingPage extends StatefulWidget {
  const NoteTakingPage({Key? key}) : super(key: key);

  @override
  State<NoteTakingPage> createState() => _NoteTakingPageState();
}

class _NoteTakingPageState extends State<NoteTakingPage> {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("notes");
  String title = '';
  String description = '';
  final TextEditingController controllerBody = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
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
              onPressed: () {
                createNote(title: title);
                Navigator.pop(context);
              },
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
                  createNote(title: title);
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

  Future createNote({required String title}) async {
    final docNote = FirebaseFirestore.instance.collection('notes').doc();
    final note = Note(
        body: description,
        title: title,
        id: docNote.id,
        email: FirebaseAuth.instance.currentUser!.email);

    final json = note.toJson();
    await docNote.set(json);
  }
}
