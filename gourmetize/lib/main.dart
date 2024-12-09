import 'package:flutter/material.dart';
import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:gourmetize/provider/avaliacao_provider.dart';
import 'package:gourmetize/provider/carrinho_provider.dart';
import 'package:gourmetize/provider/etiquetas_provider.dart';
import 'package:gourmetize/provider/receita_provider.dart';
import 'package:gourmetize/routes/routes.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      create: (ctx) => AuthProvider(),
      child: ChangeNotifierProvider(
        create: (ctx) => ReceitaProvider(),
        child: ChangeNotifierProvider(
          create: (ctx) => EtiquetasProvider(),
          child: ChangeNotifierProvider(
            create: (ctx) => AvaliacaoProvider(),
            child: ChangeNotifierProvider(
              create: (ctx) => CarrinhoProvider(),
              child: MaterialApp.router(
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
                    bodySmall:
                        TextStyle(fontSize: 16.0, color: Color(0xFF4D281E)),
                    bodyMedium:
                        TextStyle(fontSize: 20.0, color: Color(0xFF4D281E)),
                    bodyLarge:
                        TextStyle(fontSize: 24.0, color: Color(0xFF4D281E)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
