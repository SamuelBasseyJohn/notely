// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes_app/Screens/Authentication/create_account.dart';
import 'package:simple_notes_app/Screens/saved_notes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_notes_app/Widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Providers/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool? checkboxValue = false;
  bool _isVisible = false;

  Color? value = Colors.grey;
  bool isEmpty = true;
  Color colorFn(
      {String? emailtc,
      String? passwordtc,
      Color changedColor = const Color.fromARGB(255, 249, 90, 46)}) {
    if (emailtc!.isNotEmpty && passwordtc!.isNotEmpty) {
      setState(() {
        value = changedColor;
      });
      return value!;
    } else if (emailtc.isEmpty || passwordtc!.isEmpty) {
      setState(() {
        value = Colors.grey;
      });
      return value!;
    }
    return value!;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

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
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25.0),
                                child: MyText(
                                  input: "Sign in",
                                  color: "000000",
                                  fontSize: 35,
                                )),
                          ],
                        ),
                        // Set line below this widget to divide the Title from input
                        const Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
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

                        SizedBox(
                          height: 10,
                        ),

                        //Tenary operator for Checking if the required textFormFields are
                        //  filled and valid to enable color

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Signin();
                            }

                            // Signin();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(340, 50),
                            backgroundColor: value,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: const Text("Sign in"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    child: Text("Sign Up",
                        style:
                            TextStyle(color: HexColor("FA5B3D"), fontSize: 18)),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                        (route) => false),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    await provider.googleLogIn(context);
                    // ignore: unnecessary_null_comparison
                    if (provider.user != null && context.mounted) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SavedNotes()),
                          (route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("37474F"),
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Sign in with Google",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // Future signInWithGoogle() async {
  //   final provider = await Provider.of<GoogleSignInProvider>(context,
  //                       listen: false);
  //                   provider.googleLogIn();
  // }

  Future Signin() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SavedNotes()),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // ignore: avoid_print
      final error = e.toString().split(']');

      showDialog(
          barrierColor: Colors.black87,
          barrierDismissible: true,
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ok'))
                ],
                content: Text(error[1]),
              ));
      // Utils.showSnackBar(e.message);
    }

    // navigatorkey.currentState!.popUntil((route) => route.isFirst);
    // final input = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => const NoteHomePage()));
  }
}
