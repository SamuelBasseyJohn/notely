import 'package:flutter/material.dart';
import 'package:simple_notes_app/Models/favorites.dart';

class FavoriteProvider with ChangeNotifier {
  final Map<String, FavoriteNote> _favoriteNotes = {};
  Map<String, FavoriteNote> get favoriteNotes => {..._favoriteNotes};

  void addItemToFavorite(
    String id,
    String title,
    String description,
    String email,
    String timeAdded,
  ) {}
}
