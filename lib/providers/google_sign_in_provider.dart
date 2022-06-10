import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  /// [ googleSignIn ] is a private field that holds the Google sign in instance.
  final googleSignIn = GoogleSignIn();

  /// [ user ] is a private field that holds the signed in status.
  GoogleSignInAccount? user;

  /// [ getUser ] is a method that returns the signed in user.
  GoogleSignInAccount get getUser => user!;

  /// [ googleLogin ] is a method that signs in the user.
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint(e.toString());
    }

    notifyListeners();
    debugPrint("Google Login Successful");
  }

  /// [ googleLogout ] is a method that signs out the user.
  Future googleLogout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
    debugPrint("Google Logout Successful");
  }
}
