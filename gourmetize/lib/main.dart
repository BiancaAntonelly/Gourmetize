import 'package:flutter/material.dart';
import 'package:gourmetize/model/etiqueta.dart';
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
  Usuario? usuarioLogado =
      Usuario(id: 1, nome: 'Ádisson', email: 'email', senha: 'senha');
  List<Receita> receitas = [
    Receita(
      titulo: 'Bolo',
      descricao: 'Bolo de Cenoura',
      ingredientes: 'Cenoura\nFarinha\nOvos',
      preparo: 'Faça a massa\nColoque no forno',
      usuario: Usuario(id: 1, nome: 'Ádisson', email: 'email', senha: 'senha'),
    )
  ];

  void adicionarReceita(Receita receita) {
    setState(() {
      receitas.add(receita);
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
