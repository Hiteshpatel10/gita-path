import 'package:chapter/auth_module/bloc/auth_cubit.dart';
import 'package:chapter/utility/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await BlocProvider.of<AuthCubit>(context).signInUser();


            if(BlocProvider.of<AuthCubit>(context).state is AuthSuccess){

              context.pushReplacementNamed(AppRoutes.chapters);
            }

          },
          child: const Text("Sign In"),
        ),
      ),
    );
  }
}
