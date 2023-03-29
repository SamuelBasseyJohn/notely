import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Providers/google_sign_in.dart';
import 'package:simple_notes_app/Screens/saved_notes.dart';

import 'package:simple_notes_app/Widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'after_login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // ignore: unused_field
  final TextEditingController _username = TextEditingController();
  bool? checkboxValue = false;
  bool _isVisible = false;

  Color? value = Colors.grey;
  bool isEmpty = true;
  Color colorFn(
      {String? emailtc,
      String? nametc,
      String? passwordtc,
      Color changedColor = const Color.fromARGB(255, 249, 90, 46)}) {
    if (emailtc!.isNotEmpty && passwordtc!.isNotEmpty && nametc!.isNotEmpty) {
      setState(() {
        value = changedColor;
      });
      return value!;
    } else if (nametc!.isEmpty || emailtc.isEmpty || passwordtc!.isEmpty) {
      setState(() {
        value = Colors.grey;
      });
      return value!;
    }
    return value!;
  }

  String? myName;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //color of the background
      backgroundColor: Colors.grey[200],
      // SafeArea to avoid bezels
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SafeArea(
                // This container is for holding all the items
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  // I used this to add a border radius to the Container
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Row for the title 'Create your account'
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25.0),
                                child: MyText(
                                  input: "Sign Up",
                                  color: "000000",
                                  fontSize: 35,
                                )),
                          ],
                        ),
                        // Set line below this widget to divide the Title from input
                        const Divider(
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Username: ",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
                          child: TextFormField(
                            onChanged: (value) {
                              colorFn(
                                  nametc: _username.text,
                                  emailtc: _email.text,
                                  passwordtc: _password.text);
                            },
                            validator: (value) {
                              String pattern = r'\w+';
                              RegExp regex = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return "Enter your Username";
                              } else if (!regex.hasMatch(value)) {
                                return "Enter a valid Username";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _username,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: MyText(
                                    input: "Email address:", fontSize: 20)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            20.0,
                            5.0,
                            20.0,
                            15.0,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              colorFn(
                                  nametc: _username.text,
                                  emailtc: _email.text,
                                  passwordtc: _password.text);
                            },
                            validator: (value) {
                              String pattern = r'\w+@\w+.\w+';
                              RegExp regex = RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return "Enter your Email address";
                              } else if (!regex.hasMatch(value)) {
                                return "Enter a valid Email";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              hintText: "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: MyText(
                                input: "Password:",
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            20.0,
                            5.0,
                            20.0,
                            15.0,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              colorFn(
                                  nametc: _username.text,
                                  emailtc: _email.text,
                                  passwordtc: _password.text);
                            },
                            onSaved: (value) {},
                            autocorrect: false,
                            validator: ((value) {
                              if (value == null || value.isEmpty) {
                                return "Enter password";
                              } else if (value.length < 8) {
                                return "Password must not contain less than 8 digits";
                              } else {
                                return null;
                              }
                            }),
                            obscureText: !_isVisible,
                            controller: _password,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                                icon: _isVisible
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                              ),
                              hintText: "Password",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signUp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(340, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            backgroundColor: value,
                          ),
                          child: const Text("Create your account"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already got an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    child: Text("Sign In",
                        style:
                            TextStyle(fontSize: 18, color: HexColor("FA5B3D"))),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AfterLogin()),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.googleLogIn(context);
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SavedNotes()),
                        (route) => false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("37474F"),
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                label: const Text(
                  "Sign up with Google",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      )
          .then((value) {
        final user = value.user!;
        user.updateDisplayName(_username.text.trim());
      });
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => const SavedNotes()),
          (route) => false,
        );
      }
    } on FirebaseAuthException {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok')),
                  )
                ],
                content:
                    const Text('Check your internet connection and try again!'),
              ));
      // Utils.showSnackBar(e.message);
    }
    // navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
}
