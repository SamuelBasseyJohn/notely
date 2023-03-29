import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn(BuildContext context) async {
    try {
      final googleUser = await googleSignIn.signIn().catchError((error) {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => AlertDialog(
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 35)),
                        child: const Text('Ok'),
                      ),
                    )
                  ],
                  content: const Text(
                      'An error occured, check your connection settings and try again.'),
                ));
        return null;
      });
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future logout() async {
    googleSignIn.disconnect();
  }
}
