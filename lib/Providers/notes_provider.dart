import 'package:flutter/material.dart';

import '../Models/Note.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _providerNotes = [
    Note(
      id: '',
      body: '',
      title: '',
      email: '',
      timeAdded: '',
    )
  ];
  List<Note> get providerNotes => [...providerNotes];
  Note findById(String noteId) =>
      _providerNotes.firstWhere((element) => element.id == noteId);
}
