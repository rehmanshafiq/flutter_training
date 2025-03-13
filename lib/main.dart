import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_training/block_cubit/post_job_api_cubit.dart';
import 'package:flutter_training/state_management/bottom_routing_provier.dart';
import 'package:flutter_training/state_management/firebase_remote_provider.dart';
import 'package:flutter_training/state_management/image_picker_provider.dart';
import 'package:flutter_training/utils/themes.dart';
import 'package:provider/provider.dart';
import 'app_router/app_router.dart';
import 'block_cubit/get_user_api_call_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  String baseUrl = dotenv.env['BASE_URL'] ?? 'https://www.facebook.com';
  print('Base URL: $baseUrl');

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => RemoteConfigCubit(),),
            // BlocProvider(create: (context) => GetUserApiCubit(),),
            // BlocProvider(create: (context) => PostJobApiCubit(),),
          ],
          child: Container(),
        ),

        // ChangeNotifierProvider(create: (context) => RemoteConfigProvider()),
        ChangeNotifierProvider(create: (context) => BottomRoutingProvider()),
        ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.getTheme,
            routerConfig: AppRoutes.router,
          );
        },
      ),
    );
  }
}
