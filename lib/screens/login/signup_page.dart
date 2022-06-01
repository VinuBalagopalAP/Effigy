import 'package:effigy/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  final VoidCallback onClickedSignIn;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  /// [ Form Key]
  final formKey = GlobalKey<FormState>();

  /// [TextEditingController] for the email field.
  TextEditingController emailController = TextEditingController();

  /// [TextEditingController] for the password field.
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  /// [ passwordHidden ] is to defining the password is hidden.
  bool passwordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),

        /// [ Form ] for [ TextFormField ]s
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// [ TextFormField ] for [ email ]
              TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(Icons.email),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Invalid email'
                        : null,
              ),
              const SizedBox(height: 20),

              /// [ TextFormField ] for [ password ]
              TextFormField(
                obscureText: passwordHidden,
                controller: passwordController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      /// [Toggles] the password show status
                      setState(() {
                        passwordHidden = !passwordHidden;
                      });
                    },
                    icon: Icon(
                      passwordHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Password must be at least 6 characters long'
                    : null,
              ),
              const SizedBox(height: 20),

              /// [ RichTextButton ] to toggle the [ Login ]
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  text: "Already have an account?",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                      text: "Login",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      /// [ FloatingActionButton ] to [ SignUp ]
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: const Icon(Icons.new_label),
        onPressed: signUp,
        label: const Text('Sign Up'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future signUp() async {
    /// [ Form Validation ] is for checking the Email & Password is valid or not.
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    /// [ Rest Part ] this will only work is the form is valid.
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    /// [ Firebase Auth ] is for signing up the user.
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    }

    /// [ navigatorKey.currentState ] is for navigating to the [ Home ] screen.
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
