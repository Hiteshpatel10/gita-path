import 'package:chapter/auth_module/bloc/auth_cubit.dart';
import 'package:chapter/chapter_module/bloc/chapter_cubit.dart';
import 'package:chapter/chapter_module/bloc/user_activity_cubit.dart';
import 'package:chapter/theme/core_colors.dart';
import 'package:chapter/utility/navigation/go_config.dart';
import 'package:chapter/utility/services/firebase_analytics_service.dart';
import 'package:chapter/utility/services/firebase_notification_service.dart';
import 'package:chapter/verse_module/bloc/verse_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();


  await FirebaseNotificationService().initNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    try {
      final Map payload = message.data;

      FirebaseNotificationService().onNotificationClicked(payload: payload);
    } catch (e) {
      debugPrint("onDidReceiveNotificationResponse error $e");
    }
  });



  if(kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    final notificationSettings =
    await FirebaseMessaging.instance.requestPermission(provisional: true);

    runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    FirebaseNotificationService().fcmListener();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerseCubit>(create: (context) => VerseCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<ChapterCubit>(create: (context) => ChapterCubit()),
        BlocProvider<UserActivityCubit>(create: (context) => UserActivityCubit()),
      ],
      child: MaterialApp.router(
        title: 'Gita Sarathi',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: CoreColors.yellowishOrange),
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        routerConfig: goConfig,
      ),
    );
  }
}
