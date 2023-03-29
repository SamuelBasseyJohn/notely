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
  bool _isBold = false;
  bool _isItalics = false;

  final TextEditingController controllerBody = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    TextStyle selectedStyle = TextStyle(
      fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: _isItalics ? FontStyle.italic : FontStyle.normal,
    );
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
        bottomNavigationBar: BottomAppBar(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isBold = !_isBold;
                    });
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: _isBold ? Colors.grey : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Center(child: Icon(Icons.format_bold_rounded))),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isItalics = !_isItalics;
                    });
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isItalics ? Colors.grey : Colors.transparent),
                      child: const Center(
                          child: Icon(Icons.format_italic_rounded))),
                ),
                Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.abc_rounded)),
                Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.format_align_center_rounded)),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: HexColor("FFFFFF"),
          elevation: 0,
          toolbarHeight: 70,
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
                  enableInteractiveSelection: true,
                  onFieldSubmitted: (value) {
                    focusNode1.unfocus();
                    FocusScope.of(context).requestFocus(focusNode2);
                  },
                  controller: controllerTitle,
                  focusNode: focusNode1,
                  onChanged: (value) {
                    if (value.contains("/r")) {
                      FocusScope.of(context).nextFocus();
                    }
                    setState(() {
                      title = value;

                      controllerTitle.value = TextEditingValue(
                        text: value,
                        selection: controllerTitle.selection,
                      );
                    });
                  },
                  style: TextStyle(
                    fontSize: 27,
                    color: HexColor("000000"),
                    fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                    fontStyle: _isItalics ? FontStyle.italic : FontStyle.normal,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Title...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  onSaved: (value) {},
                ),
                TextFormField(
                  focusNode: focusNode2,
                  enableInteractiveSelection: true,
                  style: TextStyle(
                    fontSize: 20,
                    color: HexColor("000000"),
                    fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                    fontStyle: _isItalics ? FontStyle.italic : FontStyle.normal,
                  ),
                  maxLines: null,
                  // validator: ,
                  controller: controllerBody,
                  onChanged: (value) {
                    description = value;
                    setState(() {
                      controllerBody.value = TextEditingValue(
                        text: value,
                        selection: controllerBody.selection,
                      );
                    });
                  },
                  onTap: () {
                    print("Tap is working");
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
                        print("Selected text");
                      });
                    }
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
