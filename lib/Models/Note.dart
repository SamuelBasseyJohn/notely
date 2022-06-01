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

  Note({
    this.id = " ",
    required this.body,
    required this.title,
  });

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'description': body};
  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        body: json['description'],
      );
}
