import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Providers/favorite_provider.dart';
import 'package:simple_notes_app/Screens/home_page.dart';
import 'package:simple_notes_app/Widgets/utils_snackbar.dart';
import '../Models/Note.dart';
import '../Widgets/buttons.dart';
import '../Widgets/drawer.dart';
import '../Widgets/text.dart';
import 'EditingPages/note_editing_page.dart';
import 'note_taking_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedNotes extends StatefulWidget {
  const SavedNotes({Key? key}) : super(key: key);

  @override
  State<SavedNotes> createState() => _SavedNotesState();
}

bool iconColor = true;

enum _MenuValues {
  delete,
  addToFavorites,
}

class _SavedNotesState extends State<SavedNotes> {
  @override
  Widget build(BuildContext context) {
    IsFavoriteProvider provider = Provider.of<IsFavoriteProvider>(context);
    return Scaffold(
      drawer: const MyDrawer(),

      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
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
        //
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyText(
            input: "All Notes",
            fontSize: 32,
          ),
        ),
        actions: [
          // MyButton(
          //   icon: const Icon(
          //     Icons.search,
          //     color: Colors.black,
          //   ),
          //   onpressed: () {},
          // ),
          MyButton(
            icon: const Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            onpressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AboutNotely(),
              ),
            ),
          ),
          const SizedBox(
            width: 21,
          ),
        ],
        //Font to use, SemiBold, regular,
      ),
      //Stream builder
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .where('email',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
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
                              builder: (context) => NoteEditingPage(
                                    note: note,
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
                        child: Consumer<IsFavoriteProvider>(
                          builder: (context, _, child) => Column(
                            children: [
                              //Title
                              ListTile(
                                subtitle: MyText(
                                    input: note['timeAdded'], fontSize: 9),
                                contentPadding: const EdgeInsets.all(0),
                                horizontalTitleGap: 0,
                                trailing: PopupMenuButton<_MenuValues>(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      child:
                                          MyText(input: 'Delete', fontSize: 15),
                                      value: _MenuValues.delete,
                                    ),
                                    PopupMenuItem(
                                      child: MyText(
                                          input: note['isFavorite'] == false
                                              ? 'Add to favorites'
                                              : 'Remove from favorites',
                                          fontSize: 15),
                                      value: _MenuValues.addToFavorites,
                                    ),
                                  ],
                                  onSelected: (value) {
                                    switch (value) {
                                      case _MenuValues.delete:
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: MyText(
                                                input:
                                                    'Are you sure you want to delete this note?',
                                                fontSize: 20),
                                            actions: [
                                              //Actions, Cancel or Delete
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                  MyText(
                                                      input: '|', fontSize: 15),
                                                  TextButton(

                                                      // Delete Note
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('notes')
                                                            .doc(note['id'])
                                                            .delete();
                                                        Utils.showSnackBar(
                                                            'Delete Successful!');
                                                      },
                                                      child: MyText(
                                                          color: "FA5B3D",
                                                          input: 'Delete',
                                                          fontSize: 15)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );

                                        break;
                                      case _MenuValues.addToFavorites:
                                        Future addToFavorites() async {
                                          final docNote = FirebaseFirestore
                                              .instance
                                              .collection('notes')
                                              .doc(note['id']);

                                          final thisNote = Note(
                                              isFavorite: note['isFavorite'] ==
                                                      false
                                                  ? provider.makeFavorite()
                                                  : provider.removeFavorite(),
                                              timeAdded:
                                                  DateTime.now().toString(),
                                              body: note['description'],
                                              title: note['title'],
                                              id: docNote.id,
                                              email: FirebaseAuth
                                                  .instance.currentUser!.email);

                                          final json = thisNote.toJson();
                                          await docNote.update(json);
                                          print('Added to favorites');
                                          Utils.showSnackBar(
                                            note['isFavorite'] == false
                                                ? 'Added to Favorites!'
                                                : 'Removed from Favorites!',
                                          );
                                        }

                                        addToFavorites();
                                        break;
                                    }
                                  },
                                  icon: Icon(Icons.more_vert_rounded),
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
                      ),
                    );
                  },
                );
              }
            }
            return Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Center(
                    child: Image.asset("Images/Design-inspiration-pana.png")),
                const SizedBox(
                  height: 10,
                ),
                MyText(input: "Create your first note!", fontSize: 20),
              ],
            );
          },
        ),
      ),

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
          Icons.post_add_rounded,
          size: 30,
          color: Colors.white,
        ),
        elevation: 15,
        backgroundColor: HexColor("37474F"),
      ),
    );
  }
}
