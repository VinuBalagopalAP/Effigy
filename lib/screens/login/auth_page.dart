import 'package:effigy/screens/login/login_page.dart';
import 'package:effigy/screens/login/signup_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  /// [ isLogin] is to determine which page to show.
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(
          onClickedSignUp: toggle,
        )
      : SignUpPage(
          onClickedSignIn: toggle,
        );

  /// [ toggle ] for [ isLogin ] to switch between [ LoginPage ] and [ SignUpPage ]
  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
