import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gourmetize/screens/home.dart';
import 'package:gourmetize/screens/perfil.dart';

final GoRouter myRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
    ),
    GoRoute(
      path: '/perfil',
      builder: (BuildContext context, GoRouterState state) {
        return const Perfil();
      },
    )
  ]
);