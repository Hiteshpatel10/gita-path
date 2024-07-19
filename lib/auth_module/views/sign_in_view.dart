import 'package:chapter/auth_module/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<AuthCubit>(context).signInUser();
          },
          child: const Text("Sign In"),
        ),
      ),
    );
  }
}
