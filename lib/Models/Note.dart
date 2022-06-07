import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteField {
  static const createdTime = "createdTime";
}

class Note {
  String id;
  String title;
  String body;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? timeAdded = DateTime.now().toString();
  bool? isFavorite;

  Note({
    this.id = '',
    this.body = '',
    this.title = '',
    this.email = '',
    this.timeAdded = '',
    this.isFavorite = false,
  });

  get favorite => isFavorite;
  Map<String, dynamic> toJson() => {
        'isFavorite': isFavorite,
        'id': id,
        'title': title,
        'description': body,
        'email': email,
        'timeAdded': timeAdded
      };

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        isFavorite: json['isFavorite'],
        email: json['email'],
        id: json['id'],
        title: json['title'],
        body: json['description'],
        timeAdded: json['timeAdded']);
  }
  @override
  String toString() {
    return 'Note(id: $id, title: $title, body: $body, email: $email)';
  }
}
