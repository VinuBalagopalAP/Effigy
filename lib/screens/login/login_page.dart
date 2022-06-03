import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// [ googleSignIn ] is the instance for [ GoogleSignIn ]

final GoogleSignIn googleSignIn = GoogleSignIn(
  /// [ scopes ] is the list of scopes for the user.
  scopes: [
    'email',
  ],
);

/// [ googleSignIn.onCurrentUserChanged.listen ] is the listener for the current user, so that the user doesn't want to login again.

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? currentUser;

  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        currentUser = account;
      });
    });
    googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign in\nwith",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontStyle: FontStyle.italic,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 75),
              // Image.network(
              //   "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
              //   width: 150,
              // ),
              const SizedBox(height: 125),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/image/google_logo.png"),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black87,
                ),
                child: Text(
                  "Let's get started",
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
