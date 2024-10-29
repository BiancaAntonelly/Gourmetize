import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gourmetize/model/avaliacao.dart';
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
  List<Usuario> usuarios = [];
  Usuario? usuarioLogado;
  List<Receita> receitas = [];

  @override
  void initState() {
    super.initState();

    usuarios = [
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Adisson',
        email: 'adisson@gmail.com',
        senha: 'password',
      ),
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Bianca',
        email: 'bianca@gmail.com',
        senha: 'password',
      ),
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Rodrigo',
        email: 'rodrigo@gmail.com',
        senha: 'password',
      ),
      Usuario(
        id: Random().nextInt(10000),
        nome: 'Maria',
        email: 'maria@gmail.com',
        senha: 'password',
      ),
    ];

    receitas = [
      Receita(
        id: Random().nextInt(10000),
        titulo: 'Bolo de chocolate',
        descricao: 'Bolo de cenoura com calda de chocolate delicioso!',
        ingredientes: 'Farinha\nOvos\nCenoura\nAçucar\nLeite condensado',
        preparo: 'Faça a massa do bolo\nColoque no forno\nAguarde 30 min',
        usuario: usuarios[0],
      ),
    ];

    usuarios[0].receitas.add(receitas[0]);

    Etiqueta etiqueta = Etiqueta(nome: 'Sobremesa', usuario: usuarios[0]);

    usuarios[0].etiquetas.add(etiqueta);

    receitas[0].etiquetas.add(etiqueta);

    Avaliacao avaliacao = Avaliacao(
      nota: 4,
      comentario:
          'Receita ótima! Só deixou a desejar na explicação do modo de preparo.',
      usuario: usuarios[1],
    );

    receitas[0].avaliacoes.add(avaliacao);
  }

  void adicionarUsuario(Usuario novoUsuario) {
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

    int usuarioIndex =
        usuarios.indexWhere((u) => u.email == usuarioComId.email);

    setState(() {
      if (usuarioIndex != -1) {
        usuarios[usuarioIndex] = usuarioComId;
        print('Usuário atualizado: ${usuarioComId.nome}');
      } else {
        usuarios.add(usuarioComId);
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
    int receitaIndex = receitas.indexWhere((r) => r.id == receita.id);
    int receitaIndexUsuario =
        usuarioLogado!.receitas.indexWhere((r) => r.id == receita.id);

    print(receitaIndex);

    setState(() {
      if (receitaIndex != -1) {
        receitas[receitaIndex] = receita;
        receitas[receitaIndexUsuario] = receita;
      } else {
        receitas.add(receita);
        usuarioLogado!.receitas.add(receita);
      }
    });
  }

  void deletarReceita(Receita receita) {
    setState(() {
      receitas.removeWhere((r) => r.id == receita.id);
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
