import 'package:flutter/material.dart';
import 'package:simple_notes_app/Screens/Authentication/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_notes_app/Screens/saved_notes.dart';

class AfterLogin extends StatefulWidget {
  const AfterLogin({Key? key}) : super(key: key);

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const SavedNotes();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
