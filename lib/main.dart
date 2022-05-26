import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_notes_app/Screens/home_page.dart';
import 'package:simple_notes_app/Screens/introduction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_notes_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // brightness: Brightness.dark,
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.red,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  "Something went wrong, check your connection and try again"),
            );
          } else if (snapshot.hasData) {
            return const NoteHomePage();
          } else {
            return const IntroScreen();
          }
        },
      ),
    );
  }
}
