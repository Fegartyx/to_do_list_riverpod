import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/completed_page.dart';
import '../views/edit_view_page.dart';
import '../views/home_page.dart';
import '../views/task_page.dart';
import '../views/task_view_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routerNeglect: true,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'task_page',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const TaskPage();
          },
        ),
        GoRoute(
          path: '/completed',
          name: 'completed_page',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return const CompletedPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/task-view-page',
      name: 'task_view_page',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const TaskViewPage();
      },
    ),
    GoRoute(
      path: '/edit-view-page/:id',
      name: 'edit_view_page',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return EditViewPage(
          id: int.tryParse(state.pathParameters['id']!)!,
        );
      },
    ),
  ],
);
