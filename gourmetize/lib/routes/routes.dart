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

import '../main.dart';

final GoRouter myRouter = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return Home(
          receitas: mainAppState!.receitas,
          onCadastrarReceita: mainAppState.adicionarReceita,
          onCriarEtiqueta: mainAppState.criarEtiqueta,
        );
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
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return ReceitasUsuario(
          receitas: mainAppState!.receitas,
          onCadastrarReceita: mainAppState.adicionarReceita,
          onCriarEtiqueta: mainAppState.criarEtiqueta,
          onDeletarReceita: mainAppState.deletarReceita,
        );
      },
    ),
     GoRoute(
      path: '/receitas-favoritas',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return ReceitasFavoritas(
          receitas: mainAppState!.receitas,
          onCadastrarReceita: mainAppState.adicionarReceita,
          onCriarEtiqueta: mainAppState.criarEtiqueta,
          onDeletarReceita: mainAppState.deletarReceita,
        );
      },
    ),
    GoRoute(
      path: '/perfil',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();

        if (mainAppState != null && mainAppState.usuarioLogado != null) {
          return Perfil(
              usuarioLogado: mainAppState.usuarioLogado!,
              onDeslogarUsuario: mainAppState!.deslogarUsuario);
        } else {
          return Login();
        }
      },
    ),
    GoRoute(
      path: '/cadastrar-receita',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return RegisterRevenue(
          onCadastrarReceita: mainAppState!.adicionarReceita,
          onCriarEtiqueta: mainAppState.criarEtiqueta,
        );
      },
    ),
    GoRoute(
      path: '/editar-receita',
      builder: (BuildContext context, GoRouterState state) {
        final receitaParaEdicao = state.extra as Receita;
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return RegisterRevenue(
          onCadastrarReceita: mainAppState!.adicionarReceita,
          onCriarEtiqueta: mainAppState.criarEtiqueta,
          receitaParaEdicao: receitaParaEdicao,
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
      path: '/visualizar-receita',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return VisualizarReceita(
          receita: state.extra as Receita,
          usuarioLogado: mainAppState!.usuarioLogado!,
        );
      },
    )
  ],
);
