import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_training/state_management/firebase_remote_provider.dart';
import 'package:flutter_training/utils//themes.dart';
import 'package:provider/provider.dart';
import 'app_router/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // If using FlutterFire CLI
  );
  await dotenv.load(fileName: ".env");
  String name = dotenv.env['BASE_URL'] ?? 'https://www.facebook.com';
  print(name);

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: ChangeNotifierProvider(
          create: (_) => RemoteConfigProvider(),
          child: const MyApp(),
        ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.getTheme,
        routerConfig: AppRoutes.router,
    );
  }

}

