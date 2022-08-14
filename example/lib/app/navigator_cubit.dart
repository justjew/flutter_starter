import 'package:bloc/bloc.dart';
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
