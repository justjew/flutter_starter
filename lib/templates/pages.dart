const String pageText = '''import 'package:flutter/material.dart';

import '../../store/store.dart';
import 'views/&snakeName&_view.dart';

class &upperName&Page extends Page {
  final Store store;

  const &upperName&Page(this.store);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) {
        return const &upperName&View();
      },
    );
  }
}
''';

const String viewText = '''import 'package:flutter/material.dart';

class &upperName&View extends StatelessWidget {
  const &upperName&View({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
''';
