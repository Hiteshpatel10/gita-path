import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GoogleSignIn _googleSignIn = GoogleSignIn();

            _googleSignIn.signOut();
            _googleSignIn.signIn().then(
              (value) async {
                print("-----------$value");
                final SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setBool('signIn', true);
                await prefs.setString('email', value?.email ?? '');
              },
            );
          },
          child: const Text("Sign In"),
        ),
      ),
    );
  }
}
