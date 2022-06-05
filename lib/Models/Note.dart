import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoteField with ChangeNotifier {
  static const createdTime = "createdTime";
}

class Note with ChangeNotifier {
  String id;
  String title;
  String body;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? timeAdded = DateTime.now().toString();

  Note({
    this.id = " ",
    required this.body,
    required this.title,
    required this.email,
    required this.timeAdded,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': body,
        'email': email,
        'timeAdded': timeAdded
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
      email: json['email'],
      id: json['id'],
      title: json['title'],
      body: json['description'],
      timeAdded: json['timeAdded']);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, body: $body, email: $email)';
  }
}
