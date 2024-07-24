import 'package:chapter/auth_module/bloc/auth_cubit.dart';
import 'package:chapter/theme/core_colors.dart';
import 'package:chapter/utility/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/rasters/logo.png", height: 200, width: 200),
            const SizedBox(height: 24),
            Text(
              "Gita Sarathi",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w500, color: CoreColors.yellowishOrange),
            ),
            const SizedBox(height: 24),
            ElevatedButton(

              onPressed: () async {
                await BlocProvider.of<AuthCubit>(context).signInUser();

                Future.delayed(const Duration(milliseconds: 400), () {
                  if (BlocProvider.of<AuthCubit>(context).state is AuthSuccess) {
                    context.pushReplacementNamed(AppRoutes.chapters);
                  }
                });
              },
              child: const Text("Start Journey"),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
