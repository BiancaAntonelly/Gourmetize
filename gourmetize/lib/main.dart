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
    Receita(
      id: 1,
      titulo: 'Bolo',
      descricao: 'Bolo de Cenoura',
      ingredientes: 'Cenoura\nFarinha\nOvos',
      preparo: 'Faça a massa\nColoque no forno',
      usuario: Usuario(
          id: 1, nome: 'Ádisson', email: 'teste@gmail.com', senha: 'password'),
    )
  ];
  void adicionarUsuario(Usuario novoUsuario) {
    setState(() {
      int usuarioIndex = usuarios.indexWhere((u) => u.id == novoUsuario.id);

      if (usuarioIndex != -1) {
        // Atualizar usuário existente
        usuarios[usuarioIndex] = novoUsuario;
        print('Usuário atualizado: ${novoUsuario.nome}');
      } else {
        // Adicionar novo usuário
        usuarios.add(novoUsuario);
        print('Novo usuário adicionado: ${novoUsuario.nome}');
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
