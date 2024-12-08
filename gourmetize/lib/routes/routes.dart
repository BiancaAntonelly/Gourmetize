import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/screens/register_recipe.dart';
import 'package:gourmetize/screens/visualizar_receita.dart';
import 'package:gourmetize/screens/home.dart';
import 'package:gourmetize/screens/perfil.dart';
import 'package:gourmetize/screens/login.dart';
import 'package:gourmetize/screens/register_user.dart';
import 'package:gourmetize/screens/receitas_usuario.dart';
import 'package:gourmetize/screens/receitas_favoritas.dart';

final GoRouter myRouter = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Home();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return Login();
      },
    ),
    GoRoute(
      path: '/receitas-usuario',
      builder: (BuildContext context, GoRouterState state) {
        return ReceitasUsuario();
      },
    ),
    GoRoute(
      path: '/receitas-favoritas',
      builder: (BuildContext context, GoRouterState state) {
        return ReceitasFavoritas();
      },
    ),
    GoRoute(
      path: '/perfil',
      builder: (BuildContext context, GoRouterState state) {
        return Perfil();
      },
    ),
    GoRoute(
      path: '/cadastrar-receita',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterRevenue();
      },
    ),
    GoRoute(
      path: '/editar-receita',
      builder: (BuildContext context, GoRouterState state) {
        final receitaParaEdicao = state.extra as Receita;
        return RegisterRevenue(receitaParaEdicao: receitaParaEdicao);
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterUser();
      },
    ),
    GoRoute(
      path: '/visualizar-receita',
      builder: (BuildContext context, GoRouterState state) {
        final receita = state.extra as Receita;

        return VisualizarReceita(
          receita: receita,
        );
      },
    )
  ],
);
