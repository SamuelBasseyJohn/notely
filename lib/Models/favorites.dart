import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteNote with ChangeNotifier {
  String id;
  String title;
  String body;
  String? email = FirebaseAuth.instance.currentUser!.email;

  FavoriteNote({
    this.id = " ",
    required this.body,
    required this.title,
    required this.email,
  });
}
