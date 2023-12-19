import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_todo/features/todo/views/todo_list.dart';

final _parentKey = GlobalKey<NavigatorState>();

final routerConfig = GoRouter(
  navigatorKey: _parentKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: '/',
      name: '/',
      pageBuilder: (context, state) => const MaterialPage(child: TodoList()),
    ),
  ],
);
