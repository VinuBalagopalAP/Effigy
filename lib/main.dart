import 'package:effigy/firebase_options.dart';
import 'package:effigy/screens/home/home_page.dart';
import 'package:effigy/screens/login/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  /// [ ensureInitialized ] is a method that ensures that the Firebase is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// [ Firebase.initializeApp ] is a method to initialized the Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Effigy App',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        /// [ FirebaseAuth.instance.currentUser ] is null if the user is not logged in.
        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {

            /// [ Waiting ] for [ FirebaseAuth.instance.currentUser ] to be set.
            case ConnectionState.waiting:

              /// [ Circular progress indicator ] is shown while waiting for [ FirebaseAuth.instance.currentUser ] to be set.
              return const Center(child: CircularProgressIndicator());

            /// [ ConnectionState.done ] is reached when [ FirebaseAuth.instance.currentUser ] is set.
            case ConnectionState.done:

              /// [ snapshot.hasData ] to show [ HomePage ] if the user is logged in.
              if (snapshot.hasData) {
                return const HomePage();
              }

              /// [ AuthPage ] is shown if the user is not logged in.
              else {
                return const AuthPage();
              }

            default:

              /// [ snapshot.hasError ] to show Error message if any error occurs
              if (snapshot.hasError) {
                return const Center(child: Text('An error occurred'));
              }

              /// [ AuthPage ] is shown if the user is not logged in.
              else {
                return const AuthPage();
              }
          }
        },
      ),
    );
  }
}
