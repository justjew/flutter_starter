const String mainText = '''import 'package:flutter/material.dart';

import 'shared/hive_init.dart';
import 'shared/sentry_wrapper.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveInit();
  sentryWrap(() async => runApp(const App()));
}''';

const String dioClientText = '''import 'package:shindenshin/shindenshin.dart';

import '../config/environment.dart';

Dio getDioClient() {
  final Uri baseUri = Environment().config.apiUri;
  final BaseOptions options = BaseOptions(
    baseUrl: baseUri.toString(),
    headers: {
      'Accept-Language': 'ru-ru',
    },
  );
  return Dio(options);
}
''';

const String appText = '''import 'package:flutter/material.dart';
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
}''';

const String navigatorBuilderText = '''import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigator_cubit.dart';

class NavigatorBuilder extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const NavigatorBuilder({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorCubit, List<Page>>(
      builder: (_, pages) {
        return WillPopScope(
          onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
          child: Navigator(
            key: navigatorKey,
            pages: pages,
            onPopPage: context.read<NavigatorCubit>().onPopPage,
          ),
        );
      },
    );
  }
}
''';

const String navigatorCubitText = '''import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../store/repos.dart';
import '../store/store.dart';
import '../pages/pages.dart';

class NavigatorCubit extends Cubit<List<Page>> {
  final Store _store;

  List<Page> pages = [];

  NavigatorCubit(this._store) : super([SplashPage(_store)]);

  void home() {
    _replacePage(HomePage(_store), replaceAll: true);
  }

  bool onPopPage(Route route, dynamic result) {
    pages.removeLast();
    return route.didPop(result);
  }

  void _addPage(Page page) {
    pages = [...pages, page];
    emit(pages);
  }

  void _replacePage(Page page, {bool replaceAll = false}) {
    if (replaceAll) {
      pages = [page];
    } else {
      pages = List.of(pages..removeLast());
    }
    emit(pages);
  }

  void _popPage([int depth = 1]) {
    final int length = pages.length;
    int _depth = depth;
    if (_depth >= length) {
      _depth = length - 1;
    }
    pages.removeRange(length - _depth, length);
    emit(List.of(pages));
  }
}
''';