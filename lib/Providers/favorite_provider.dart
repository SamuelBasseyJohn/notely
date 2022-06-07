import 'package:flutter/material.dart';

class IsFavoriteProvider extends ChangeNotifier {
  bool isFavorite = false;

  bool makeFavorite() {
    bool makeFavorite = !isFavorite;
    notifyListeners();
    return makeFavorite;
  }

  bool removeFavorite() {
    bool makeFavorite = isFavorite;
    notifyListeners();
    return makeFavorite;
  }
}
