import 'package:chapter/auth_module/bloc/auth_cubit.dart';
import 'package:chapter/chapter_module/bloc/chapter_cubit.dart';
import 'package:chapter/theme/core_colors.dart';
import 'package:chapter/utility/navigation/go_config.dart';
import 'package:chapter/verse_module/bloc/verse_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCdJoD0lKc_I-BmX9Gh6PigzjyHbo0Fygk",
      appId: "1:393406614769:android:2dc622a37a64da1df36d50",
      messagingSenderId: "393406614769 ",
      projectId: "gita-sarathi",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerseCubit>(create: (context) => VerseCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ChapterCubit>(create: (context) => ChapterCubit()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: CoreColors.yellowishOrange),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 54),
              // foregroundColor: CoreColors.yellowishOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        ),
        routerConfig: goConfig,
      ),
    );
  }
}
