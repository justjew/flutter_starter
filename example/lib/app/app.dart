import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shindenshin/shindenshin.dart';

import '../store/store.dart';
import 'dio_client.dart';
import 'navigator_cubit.dart';
import 'navigator_builder.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late final BaseApiClient apiClient;
  late final Store store;

  @override
  void initState() {
    super.initState();

    final Dio dioClient = getDioClient();
    apiClient = BaseApiClient(dioClient);
    store = Store(apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigatorCubit>(
      create: (_) => NavigatorCubit(store),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru')],
        home: NavigatorBuilder(
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }
}