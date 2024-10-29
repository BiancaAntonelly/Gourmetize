import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/routes/routes.dart';
import 'package:gourmetize/model/receita.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<Usuario> usuarios = [
    Usuario(id: 1, nome: 'Ádisson', email: 'teste@gmail.com', senha: 'password')
  ];
  Usuario? usuarioLogado;
  List<Receita> receitas = [
    Receita
      id: Random().nextInt(10000),
      titulo: 'Bolo',
      descricao: 'Bolo de Cenoura',
      ingredientes: 'Cenoura\nFarinha\nOvos',
      preparo: 'Faça a massa\nColoque no forno',
      usuario: Usuario(id: 2, nome: 'Ádisson', email: 'email', senha: 'senha'),
    )
  ];
  void adicionarUsuario(Usuario novoUsuario) {
    setState(() {
      // Gera um novo ID, garantindo que não haverá repetição.
      int novoId = 1; // Começamos com 1
      if (usuarios.isNotEmpty) {
        // Se já houver usuários, pegamos o maior ID atual e incrementamos.
        novoId = usuarios.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1;
      }

      // Cria uma nova instância de Usuario com o novo ID.
      Usuario usuarioComId = Usuario(
        id: novoId,
        nome: novoUsuario.nome,
        email: novoUsuario.email,
        senha: novoUsuario.senha,
        receitas: novoUsuario.receitas,
        etiquetas: novoUsuario.etiquetas,
      );

      // Verifica se o usuário já existe pelo email.
      int usuarioIndex =
          usuarios.indexWhere((u) => u.email == usuarioComId.email);

      if (usuarioIndex != -1) {
        // Atualizar usuário existente
        usuarios[usuarioIndex] = usuarioComId;
        print('Usuário atualizado: ${usuarioComId.nome}');
      } else {
        // Adicionar novo usuário
        usuarios.add(usuarioComId);
        print('Novo usuário adicionado: ${usuarioComId.nome}');
      }
    });
  }

  void logarUsuario(Usuario usuario) {
    setState(() {
      usuarioLogado = usuario;
    });
    print('Usuário logado: ${usuario.nome}');
  }

  void deslogarUsuario() {
    setState(() {
      usuarioLogado = null;
    });
  }

  void adicionarReceita(Receita receita) {
    setState(() {
      int receitaIndex = receitas.indexWhere((r) => r.id == receita.id);

      if (receitaIndex != -1) {
        // Atualizar receita existente
        receitas[receitaIndex] = receita;
        print('Receita atualizada: ${receita.titulo}');
      } else {
        // Adicionar nova receita
        receitas.add(receita);
        print('Nova receita cadastrada: ${receita.titulo}');
      }
    });
  }

  void criarEtiqueta(Etiqueta etiqueta) {
    print(usuarioLogado!.nome);

    if (usuarioLogado == null) {
      return;
    }

    setState(() {
      usuarioLogado!.etiquetas.add(etiqueta);
    });
  }

  void adicionarEtiquetaAReceita(Receita receita, Etiqueta etiqueta) {
    int index = receitas.indexWhere((item) => item.id == receita.id);

    if (index == -1) {
      return;
    }

    setState(() {
      receitas[index].etiquetas.add(etiqueta);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter,
      theme: ThemeData(
        primaryColor: const Color(0xFF4D281E),
        secondaryHeaderColor: const Color(0xFFFFCC00),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
        ).copyWith(
          primary: const Color(0xFF4D281E),
          secondary: const Color(0xFFFFCC00),
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 16.0, color: Color(0xFF4D281E)),
          bodyMedium: TextStyle(fontSize: 20.0, color: Color(0xFF4D281E)),
          bodyLarge: TextStyle(fontSize: 24.0, color: Color(0xFF4D281E)),
        ),
      ),
    );
  }
}
