import 'package:flutter/material.dart';

import '../../store/store.dart';
import 'views/splash_view.dart';

class SplashPage extends Page {
  final Store store;

  const SplashPage(this.store);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) {
        return const SplashView();
      },
    );
  }
}
