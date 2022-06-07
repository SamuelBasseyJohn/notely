import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_notes_app/Widgets/drawer.dart';
import '../Models/Note.dart';
import '../Widgets/buttons.dart';
import '../Widgets/text.dart';
import '../Widgets/utils_snackbar.dart';
import 'EditingPages/fav_note_edit_page.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFFFFF"),
      drawer: const MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: HexColor("FFFFFF"),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),

        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyText(
            input: "Favorites",
            fontSize: 32,
          ),
        ),

        //Font to use, SemiBold, regular,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .where('isFavorite', isEqualTo: true)
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
              return DragSelectGridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 2,
                    mainAxisExtent: 250),
                itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                itemBuilder: (BuildContext context, index, isSelected) {
                  final note = snapshot.data!.docs[index].data();
                  // ignore: unused_local_variable
                  final edit = snapshot.data!.docs[index].data();
                  return GestureDetector(
                    onLongPress: () {},
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavNoteEditingPage(
                                  favNote: note,
                                ))),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(13),
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
                          //Title
                          ListTile(
                            subtitle:
                                MyText(input: note['timeAdded'], fontSize: 8),
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            trailing: MyButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                                size: 25,
                              ),
                              onpressed: () {
                                // FirebaseFirestore.instance
                                //     .collection('notes')
                                //     .doc(note['id'])
                                //     .delete();
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: MyText(
                                        input:
                                            'Remove this note from favorites ?',
                                        fontSize: 20),
                                    actions: [
                                      //Actions, Cancel or Delete
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: MyText(
                                                color: "FA5B3D",
                                                input: 'Cancel',
                                                fontSize: 15),
                                          ),
                                          MyText(input: '|', fontSize: 15),
                                          TextButton(

                                              // Delete Note
                                              onPressed: () {
                                                Future
                                                    removeFromFavorites() async {
                                                  final docNote =
                                                      FirebaseFirestore.instance
                                                          .collection('notes')
                                                          .doc(note['id']);

                                                  final thisNote = Note(
                                                      isFavorite: false,
                                                      timeAdded: DateTime.now()
                                                          .toString(),
                                                      body: note['description'],
                                                      title: note['title'],
                                                      id: docNote.id,
                                                      email: FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .email);

                                                  final json =
                                                      thisNote.toJson();
                                                  await docNote.update(json);

                                                  Utils.showSnackBar(
                                                    'Removed from Favorites!',
                                                  );
                                                }

                                                removeFromFavorites();

                                                Navigator.pop(context);
                                              },
                                              child: MyText(
                                                  color: "FA5B3D",
                                                  input: 'Remove',
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            title: MyText(
                                overflow: TextOverflow.ellipsis,
                                input: note['title'] ??= "No title",
                                fontSize: 25),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Container(
                            alignment: const Alignment(-1, -0.6),
                            child: MyText(
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                input: note['description'] ??= "",
                                fontSize: 15.02),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: MyText(input: "No favorite note yet!", fontSize: 20),
          );
        },
      ),
    );
  }
}
