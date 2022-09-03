import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Models/Note.dart';

class FavNoteEditingPage extends StatefulWidget {
  final Map favNote;
  const FavNoteEditingPage({Key? key, required this.favNote}) : super(key: key);

  @override
  State<FavNoteEditingPage> createState() => _FavNoteEditingPageState();
}

class _FavNoteEditingPageState extends State<FavNoteEditingPage> {
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
    title = widget.favNote['title'];
    description = widget.favNote['description'];
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: HexColor("FFFFFF"),
        appBar: AppBar(
          title: TextFormField(
            // validator: ,
            // controller: controllerTitle,
            initialValue: title,
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
            onSaved: (value) {
              setState(() {
                title = value!;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "can't be empty";
              } else {
                return null;
              }
            },
            style: TextStyle(fontSize: 27, color: HexColor("000000")),
            decoration: const InputDecoration(
              hintText: "Title...",
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 27,
              ),
            ),
            // onSaved: (value) {},
          ),
          backgroundColor: HexColor("FFFFFF"),
          elevation: 2,
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  updateFavNote(
                      update: Note(
                          isFavorite: true,
                          timeAdded: DateTime.now().toString(),
                          body: description,
                          title: title,
                          email: FirebaseAuth.instance.currentUser!.email,
                          id: widget.favNote['id']));
                  Navigator.pop(context);
                } else {
                  return;
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),

          actions: [
            IconButton(
                icon: const Icon(
                  Icons.save_as_outlined,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    updateFavNote(
                        update: Note(
                            isFavorite: true,
                            timeAdded: DateTime.now().toString(),
                            body: description,
                            title: title,
                            email: FirebaseAuth.instance.currentUser!.email,
                            id: widget.favNote['id']));
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                }),
            const SizedBox(
              width: 21,
            ),
          ],
          //Font to use, SemiBold, regular,
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
                  // controller: controllerBody,
                  initialValue: description,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can't be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      description = value!;
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateFavNote({required Note update}) async {
    final favDocNote = FirebaseFirestore.instance
        .collection('notes')
        .doc(widget.favNote['id']);

    await favDocNote.update(update.toJson());
  }

  //Add to Favorites Method

}
