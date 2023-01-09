import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Widgets/buttons.dart';
import 'package:simple_notes_app/Models/note.dart';

class NoteTakingPage extends StatefulWidget {
  const NoteTakingPage({Key? key}) : super(key: key);

  @override
  State<NoteTakingPage> createState() => _NoteTakingPageState();
}

class _NoteTakingPageState extends State<NoteTakingPage> {
  final reference =
      FirebaseFirestore.instance.collection("notes").doc('isFavorite');
  String title = '';
  String description = '';
  final TextEditingController controllerBody = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future<void> createNote({
      required String title,
    }) async {
      final docNote = FirebaseFirestore.instance.collection('notes').doc();
      final note = Note(
          isFavorite: false,
          timeAdded: DateTime.now().toString(),
          body: description,
          title: title,
          id: docNote.id,
          email: FirebaseAuth.instance.currentUser!.email);

      final json = note.toJson();
      await docNote.set(json);
    }

    return Form(
      key: _formKey,
      child: Scaffold(
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
              if (controllerBody.text.isEmpty && controllerTitle.text.isEmpty) {
                Navigator.pop(context);
              } else {
                createNote(title: title);
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          actions: [
            // Change font size
            IconButton(
                onPressed: () {}, icon: Icon(Icons.font_download_outlined)),

            SizedBox(
              width: 10,
            ),
            //Save Notes
            Consumer(
              // ignore: non_constant_identifier_names
              builder: (context, IsFavoriteProvider, child) => MyButton(
                  icon: const Icon(
                    Icons.save_as_outlined,
                  ),
                  onpressed: () {
                    createNote(title: title);
                    Navigator.pop(context);
                  }),
            ),
            const SizedBox(
              width: 21,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                  decoration: const InputDecoration(
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
      ),
    );
  }
}
