import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_training/state_management/firebase_remote_config_cubit.dart';
import 'package:flutter_training/utils/themes.dart';
import 'package:provider/provider.dart';
import 'app_router/app_router.dart';
import 'firebase_options.dart';
import 'graphql/collection_query.dart';
import 'graphql/graphql_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  String baseUrl = dotenv.env['BASE_URL'] ?? 'https://www.facebook.com';
  print('Base URL: $baseUrl');

  String shopifyBaseUrl = dotenv.env['SHOPIFY_BASE_URL'] ?? "";
  String accessToken = dotenv.env['ACCESS_TOKEN'] ?? "";

  print("SHOPIFY BASE URL::: $shopifyBaseUrl ACCESS_TOKEN $accessToken");

  final graphQLService = GraphQLService(shopifyBaseUrl, accessToken);
  final response = await graphQLService.performQuery(CollectionsQuery);
  print("GRAPH_QL RESPONSE:::: ${response.data}");

  var response2 = await graphQLService.performQueryWithParams(
    query: collectionsQuery,
    params: collectionsParams,
  );

  print("GraphQL Response222::: ${response2.data}");

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
          ],
          child: Container(),
        ),
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
