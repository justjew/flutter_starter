import 'package:flutter/material.dart';

import '../../store/store.dart';
import 'views/home_view.dart';

class HomePage extends Page {
  final Store store;

  const HomePage(this.store);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) {
        return const HomeView();
      },
    );
  }
}
