import 'package:effigy/common/effigy_button.dart';
import 'package:effigy/common/sizes_helpers.dart';
import 'package:effigy/providers/google_sign_in_provider.dart';
import 'package:effigy/screens/auth/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Image.asset(
                  'assets/bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: displayWidth(context) * 0.5,
                      child: Text(
                        'Save your\nmoments',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: displayWidth(context) * 0.09,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.8,
                      child: Text(
                        'Online!',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: displayWidth(context) * 0.15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    EffigyButton(
                      onpressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false,
                        );

                        provider.googleLogin();
                        debugPrint('Google Login');
                      },
                      child: const LoginGoogle(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
