import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/routes/routes.dart'; // Certifique-se de que este caminho esteja correto
import 'package:gourmetize/model/receita.dart'; // Certifique-se de que seu modelo Receita está definido

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<Receita> receitas = [];
  List<Usuario> usuarios = [];
  Usuario? userLogado;

  void cadastrarUsuario(String nome, String email, String senha) {
    final usuarioExistente = usuarios.firstWhere(
      (user) => user.email == email,
      orElse: () => Usuario(id: -1, nome: '', email: '', senha: ''),
    );

    if (usuarioExistente.id == -1) {
      final novoUsuario = Usuario(
        id: usuarios.length + 1,
        nome: nome,
        email: email,
        senha: senha,
      );

      setState(() {
        usuarios.add(novoUsuario);
      });

      print('Usuário cadastrado com sucesso: $nome');
    } else {
      print('Email já está em uso: $email');
    }
  }

  void adicionarReceita(
      String titulo, String ingredientes, String descricao, String preparo) {
    final novaReceita = Receita(
      id: receitas.length + 1,
      titulo: titulo,
      ingredientes: ingredientes,
      descricao: descricao,
      preparo: preparo,
    );

    setState(() {
      receitas.add(novaReceita); // Adiciona a nova receita à lista
    });

    // Imprimir todas as receitas no console
    print('Receitas cadastradas:');
    for (var receita in receitas) {
      print(
          'ID: ${receita.id}, Título: ${receita.titulo}, Ingredientes: ${receita.ingredientes}, Descrição: ${receita.descricao}, Modo de Preparo: ${receita.preparo}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter,
      theme: ThemeData(
          // Defina seu tema aqui
          ),
    );
  }
}
