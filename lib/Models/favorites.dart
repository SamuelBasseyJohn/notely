import 'package:simple_notes_app/Models/note.dart';

class Favorite {
  final List<Note> _favoritesList = [];

  List<Note> get favoritesList => _favoritesList;

//  Future addToFavorites() async {
//     final docNote = FirebaseFirestore.instance
//         .collection('notes')
//         .doc(FirebaseAuth.instance.currentUser!.email);
//     final favDocNote = docNote.collection('favorite notes').doc();
//     final favNote = Note(
//         isFavorite: false,
//         timeAdded: DateTime.now().toString(),
//         body: description,
//         title: title,
//         id: docNote.id,
//         email: FirebaseAuth.instance.currentUser!.email);

//     final json = favNote.toJson();
//     await favDocNote.set(json);
//     print('Added to favorites');
//     Utils.showSnackBar('Added to Favorites!');
//   }
}
