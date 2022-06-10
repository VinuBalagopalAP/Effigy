import 'package:effigy/providers/google_sign_in_provider.dart';
import 'package:effigy/screens/auth/auth.dart';
import 'package:effigy/screens/home/homepage.dart';
import 'package:effigy/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future main() async {
  /// [ ensureInitialized ] to ensure that the Firebase app is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// [ initializeApp ] to wait for the Firebase app to be initialized.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        theme: EffigyTheme.theme,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {

              /// [ Waiting ] for [ FirebaseAuth.instance.currentUser ] to be set.
              case ConnectionState.waiting:

                /// [ Circular progress indicator ] is shown while waiting for [ FirebaseAuth.instance.currentUser ] to be set.

                return const Center(
                  child: CircularProgressIndicator(),
                );

              /// [ ConnectionState.active ] is reached when [ FirebaseAuth.instance.currentUser ] is set.

              case ConnectionState.active:

                /// [ snapshot.hasData ] to show [ HomePage ] if the user is logged in.

                if (snapshot.hasData) {
                  debugPrint("User is logged in");
                  return const HomePage();
                }

                /// [ AuthPage ] is shown if the user is not logged in.
                debugPrint("Try to login again");
                return const AuthPage();

              default:

                /// [ snapshot.hasError ] to show Error message if any error occurs
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                }

                /// [ AuthPage ] is shown if the user is not logged in.
                debugPrint("User not logged in");
                return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
