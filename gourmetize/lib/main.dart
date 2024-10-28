import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  void adicionarReceita(String titulo, String ingredientes, String descricao, String preparo) {
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
      print('ID: ${receita.id}, Título: ${receita.titulo}, Ingredientes: ${receita.ingredientes}, Descrição: ${receita.descricao}, Modo de Preparo: ${receita.preparo}');
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
