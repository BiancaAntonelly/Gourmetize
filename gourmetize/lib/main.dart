import 'package:flutter/material.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:gourmetize/provider/avaliacao_provider.dart';
import 'package:gourmetize/provider/carrinho_provider.dart';
import 'package:gourmetize/provider/etiquetas_provider.dart';
import 'package:gourmetize/provider/receita_provider.dart';
import 'package:gourmetize/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
