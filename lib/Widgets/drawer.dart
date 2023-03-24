import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Providers/google_sign_in.dart';
import 'package:simple_notes_app/Screens/favorites_page.dart';
import 'package:simple_notes_app/Screens/saved_notes.dart';
import 'package:simple_notes_app/Widgets/text.dart';

import '../Screens/introduction_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final name = user.displayName ?? "No Name";
    final image = user.photoURL;
    final googleProvider = Provider.of<GoogleSignInProvider>(context);
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(0, 20, 16, 8),
            duration: const Duration(milliseconds: 250),
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    "Notely",
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                  minLeadingWidth: 20,
                  leading: CircleAvatar(
                    radius: 40,
                    child: image == null
                        ? const Icon(Icons.person)
                        : ClipOval(
                            child: Image(
                              image: NetworkImage(user.photoURL!),
                            ),
                          ),
                  ),
                  title: Text(name),
                  subtitle: Text(
                    user.email!,
                    style: const TextStyle(fontSize: 12),
                  ),
                  dense: false,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.book,
              size: 30,
            ),
            title: MyText(input: "All notes", fontSize: 20),
            onTap: () => Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => const SavedNotes())),
          ),
          ListTile(
            leading: const Icon(
              Icons.star_border_rounded,
              size: 32,
            ),
            title: MyText(input: "Favorites", fontSize: 20),
            onTap: () => Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const Favorites())),
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_sharp,
              size: 30,
            ),
            title: MyText(input: "Sign-out", fontSize: 20),
            onTap: () async {
              await Future.delayed(const Duration(milliseconds: 700));
              googleProvider.logout();
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const IntroScreen()),
                    (route) => false);
              }

              // Utils.showSnackBar('Signed out!');
            },
          ),
          Divider(
            color: Colors.grey[600],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
