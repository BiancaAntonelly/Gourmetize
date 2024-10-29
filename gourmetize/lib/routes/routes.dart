import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/screens/register_revenue.dart';
import 'package:gourmetize/screens/visualizar_receita.dart';
import 'package:gourmetize/screens/home.dart';
import 'package:gourmetize/screens/perfil.dart';
import 'package:gourmetize/screens/login.dart';
import 'package:gourmetize/screens/register_user.dart';
import 'package:gourmetize/screens/receitas_usuario.dart';

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
          usuarioLogado: mainAppState.usuarioLogado!,
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();

        return Login(
          usuarios: mainAppState!.usuarios,
          onLogarUsuario: mainAppState.logarUsuario,
        );
      },
    ),
    GoRoute(
      path: '/receitas-usuario',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return ReceitasUsuario(
          receitas: mainAppState!.receitas,
          onCadastrarReceita: mainAppState!.adicionarReceita,
          onCriarEtiqueta: mainAppState!.criarEtiqueta,
          usuarioLogado: mainAppState.usuarioLogado!,
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
          return Login(
              usuarios: mainAppState!.usuarios,
              onLogarUsuario: mainAppState.logarUsuario);
        }
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return Login(
            usuarios: mainAppState!.usuarios,
            onLogarUsuario: mainAppState.logarUsuario);
      },
    ),
    GoRoute(
      path: '/cadastrar-receita',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();
        return RegisterRevenue(
          onCadastrarReceita: mainAppState!.adicionarReceita,
          onCriarEtiqueta: mainAppState!.criarEtiqueta,
          usuarioLogado: mainAppState.usuarioLogado!,
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
          onCriarEtiqueta: mainAppState!.criarEtiqueta,
          usuarioLogado: mainAppState.usuarioLogado!,
          receitaParaEdicao: receitaParaEdicao,
        );
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        final mainAppState = context.findAncestorStateOfType<MyAppState>();

        return RegisterUser(
            onAddUsuario: mainAppState!.adicionarUsuario,
            usuarios: mainAppState.usuarios);
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
