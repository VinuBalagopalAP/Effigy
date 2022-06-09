import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login Page', style: TextStyle(fontSize: 30)),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text("Sign In with Google"),
                icon: const FaIcon(FontAwesomeIcons.google),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
