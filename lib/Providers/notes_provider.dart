import 'package:flutter/material.dart';

import '../Models/Note.dart';

class NoteProvider extends ChangeNotifier {
  //All notes to be displayed
  final List<Note> _providerNotes = [
    Note(
      isFavorite: false,
      id: '',
      body: '',
      title: '',
      email: '',
      timeAdded: '',
    )
  ];
  //retrieve notes
  List<Note> get providerNotes => _providerNotes;
  Note findById(String noteId) =>
      _providerNotes.firstWhere((element) => element.id == noteId);
  //Favorite Notes
  final List<Note> _favoriteNotes = [];

  //retrieve Favorites
  List<Note> get favoriteNotes => _favoriteNotes;

  //Adding note to favorites
  void addToFavoritesList(Note note) {
    _favoriteNotes.add(note);
    notifyListeners();
  }

  void removeFromFavoritesList(Note note) {
    _favoriteNotes.remove(note);
    notifyListeners();
  }
}
