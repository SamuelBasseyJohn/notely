import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Models/Note.dart';
import '../../Widgets/utils_snackbar.dart';

class NoteEditingPage extends StatefulWidget {
  final Map note;
  const NoteEditingPage({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteEditingPage> createState() => _NoteEditingPageState();
}

class _NoteEditingPageState extends State<NoteEditingPage> {
  final reference = FirebaseFirestore.instance.collection("notes").doc();
  String title = '';
  String description = '';
  final bool _isBold = false;
  final bool _isItalics = false;
  final TextEditingController controllerBody = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool starFavorite = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    title = widget.note['title'];
    description = widget.note['description'];
    return Form(
      key: _formKey,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.format_bold_rounded)),
                Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.format_italic_rounded)),
                Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.abc_rounded)),
                Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.format_align_center_rounded)),
              ],
            ),
          ),
        ),
        backgroundColor: HexColor("FFFFFF"),
        appBar: AppBar(
          backgroundColor: HexColor("FFFFFF"),
          elevation: 2,
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  updateNote(
                      update: Note(
                          isFavorite: false,
                          timeAdded: DateTime.now().toString(),
                          body: description,
                          title: title,
                          email: FirebaseAuth.instance.currentUser!.email,
                          id: widget.note['id']));
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
                    updateNote(
                        update: Note(
                            isFavorite: false,
                            timeAdded: DateTime.now().toString(),
                            body: description,
                            title: title,
                            email: FirebaseAuth.instance.currentUser!.email,
                            id: widget.note['id']));
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
                  onTap: () {
                    final currentSelection = controllerTitle.selection;
                    final selectedText =
                        currentSelection.textInside(controllerTitle.text);
                    if (selectedText.isNotEmpty) {
                      final startIndex = currentSelection.start;
                      final endIndex = currentSelection.end;
                      final newSelection =
                          TextSelection.collapsed(offset: endIndex);
                      final newText = controllerTitle.text.replaceRange(
                        startIndex,
                        endIndex,
                        selectedText,
                      );
                      setState(() {
                        controllerTitle.value = TextEditingValue(
                          selection: newSelection,
                          text: newText,
                        );
                      });
                    }
                  },
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
                TextFormField(
                  style: TextStyle(fontSize: 20, color: HexColor("000000")),
                  onTap: () {
                    final currentSelection = controllerBody.selection;
                    final selectedText =
                        currentSelection.textInside(controllerBody.text);
                    if (selectedText.isNotEmpty) {
                      final startIndex = currentSelection.start;
                      final endIndex = currentSelection.end;
                      final newSelection =
                          TextSelection.collapsed(offset: endIndex);
                      final newText = controllerBody.text.replaceRange(
                        startIndex,
                        endIndex,
                        selectedText,
                      );
                      setState(() {
                        controllerBody.value = TextEditingValue(
                          selection: newSelection,
                          text: newText,
                        );
                        print('Selected');
                      });
                    }
                  },
                  maxLines: null,
                  initialValue: description,
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
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

  Future updateNote({
    required Note update,
  }) async {
    final docNote =
        FirebaseFirestore.instance.collection('notes').doc(widget.note['id']);

    await docNote.update(update.toJson());
  }

  //Add to Favorites Method
  Future addToFavorites() async {
    final docNote = FirebaseFirestore.instance
        .collection('notes')
        .doc(FirebaseAuth.instance.currentUser!.email);
    final favDocNote =
        docNote.collection('favorite notes').doc(widget.note['id']);
    final favNote = Note(
        isFavorite: false,
        timeAdded: DateTime.now().toString(),
        body: description,
        title: title,
        id: docNote.id,
        email: FirebaseAuth.instance.currentUser!.email);

    final json = favNote.toJson();
    await favDocNote.set(json);

    Utils.showSnackBar('Added to Favorites!');
  }
}
