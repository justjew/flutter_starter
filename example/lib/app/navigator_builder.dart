import 'package:flutter/material.dart';
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
