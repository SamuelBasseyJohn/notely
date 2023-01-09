import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Models/notes_operation.dart';
import 'package:simple_notes_app/Providers/notes_provider.dart';
import 'package:simple_notes_app/Screens/favorites_page.dart';
import 'package:simple_notes_app/Screens/home_page.dart';
import 'package:simple_notes_app/Screens/introduction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_notes_app/Firebase/firebase_options.dart';

import 'Providers/favorite_provider.dart';
import 'Providers/google_sign_in.dart';
import 'Screens/saved_notes.dart';
import 'Widgets/utils_snackbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IsFavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        initialRoute: '/',
        routes: {
          '/login': (context) => const IntroScreen(),
        },
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorkey,
        debugShowCheckedModeBanner: false,
        title: 'Notely',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme:
              GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
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
              return const SavedNotes();
            } else {
              return const IntroScreen();
            }
          },
        ),
      ),
    );
  }
}
