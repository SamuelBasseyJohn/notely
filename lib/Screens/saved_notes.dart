import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_notes_app/Models/note.dart';
import 'package:simple_notes_app/Screens/home_page.dart';
import '../Widgets/buttons.dart';
import '../Widgets/drawer.dart';
import '../Widgets/text.dart';
import 'note_editing_page.dart';
import 'note_taking_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedNotes extends StatefulWidget {
  const SavedNotes({Key? key}) : super(key: key);

  @override
  State<SavedNotes> createState() => _SavedNotesState();
}

bool iconColor = true;

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
            fontSize: 35,
          ),
        ),
        actions: [
          MyButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onpressed: () {},
          ),
          MyButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onpressed: () {},
          ),
          const SizedBox(
            width: 21,
          ),
        ],
        //Font to use, SemiBold, regular,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (
          context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 2,
                    mainAxisExtent: 250),
                itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, index) {
                  final note = snapshot.data!.docs[index].data();
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteEditingPage(
                                  note: note,
                                ))),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(15),
                      height: 100,
                      decoration: BoxDecoration(
                        color: HexColor("FFFFFF"),
                        // border: Border.all(
                        //   width: 3,
                        // ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Container(
                          //   alignment: Alignment(1.3, -1.11),
                          //   child: MyButton(
                          //     icon: Icon(
                          //       Icons.star_rounded,
                          //       color: iconColor ? Colors.yellow : Colors.grey,
                          //     ),
                          //     onpressed: () {
                          //       setState(() {
                          //         iconColor == !iconColor;
                          //       });
                          //     },
                          //   ),
                          // ),
                          ListTile(
                              contentPadding: EdgeInsets.all(0),
                              horizontalTitleGap: 0,
                              trailing: MyButton(
                                icon: Icon(
                                  Icons.star_rounded,
                                  color:
                                      iconColor ? Colors.yellow : Colors.grey,
                                ),
                                onpressed: () {
                                  setState(() {
                                    iconColor == !iconColor;
                                  });
                                },
                              ),
                              title: MyText(
                                  overflow: TextOverflow.ellipsis,
                                  input: note['title'] ??= "",
                                  fontSize: 23)),
                          Container(
                              alignment: Alignment(-1, -0.6),
                              child: MyText(
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  input: note['description'] ??= "",
                                  fontSize: 15))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Column(
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
          );
        },
      ),

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
          color: Colors.white,
        ),
        elevation: 15,
        backgroundColor: HexColor("37474F"),
      ),
    );
  }
}
