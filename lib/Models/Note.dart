import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoteField {
  static const createdTime = "createdTime";
}

class Note {
  String id;
  String title;
  String body;
  String? email = FirebaseAuth.instance.currentUser!.email;

  Note({
    this.id = " ",
    required this.body,
    required this.title,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': body,
        'email': email,
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        email: json['email'],
        id: json['id'],
        title: json['title'],
        body: json['description'],
      );
}
