import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/screens/register_revenue.dart';
import 'package:gourmetize/screens/avaliacoes.dart';
import 'package:gourmetize/screens/home.dart';
import 'package:gourmetize/screens/perfil.dart';
import 'package:gourmetize/screens/login.dart';
import 'package:gourmetize/screens/register_user.dart';

import '../main.dart';

final GoRouter myRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return Home(receitas: mainAppState!.receitas);
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
        return const Login();
      },
    ),
    GoRoute(
      path: '/cadastrar-receita',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return RegisterRevenue(
          onCadastrarReceita: mainAppState!.adicionarReceita,
        );
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterUser();
      },
    ),
    GoRoute(
      path: '/avaliacoes',
      builder: (BuildContext context, GoRouterState state) {
        return Avaliacoes(
          receita: state.extra as Receita,
        );
      },
    )
  ],
);
