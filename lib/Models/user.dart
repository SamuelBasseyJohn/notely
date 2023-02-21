import 'package:simple_notes_app/Models/note.dart';

class User {
  Note userNote;
  String email;
  String name;
  User({required this.userNote, required this.email, required this.name});
}
