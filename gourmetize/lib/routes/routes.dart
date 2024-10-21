import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gourmetize/screens/home.dart';
import 'package:gourmetize/screens/perfil.dart';
import 'package:gourmetize/screens/LoginScreen.dart';
import 'package:gourmetize/screens/RegisterScreen.dart';

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
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    //GoRoute(
    //  path: '/register',
    //  builder: (BuildContext context, GoRouterState state) {
    //   return const RegisterScreen(); // Tela de Cadastro
    // },
    //),
  ],
);
