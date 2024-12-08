import 'package:flutter/material.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:gourmetize/provider/receita_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';

class ReceitasFavoritas extends StatefulWidget {
  ReceitasFavoritas({
    super.key,
  });

  @override
  _ReceitasFavoritasState createState() => _ReceitasFavoritasState();
}

class _ReceitasFavoritasState extends State<ReceitasFavoritas> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final usuarioLogado =
        Provider.of<AuthProvider>(context, listen: false).usuarioLogado!;
    context.read<ReceitaProvider>().buscarReceitas(usuarioLogado).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: '',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const StyledText(title: "Receitas Favoritas"),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<ReceitaProvider>(
                builder: (context, receitaProvider, child) {
                  return ListaReceitas(
                    pertencemAoUsuario: false,
                    receitas: context.watch<ReceitaProvider>().favoritas,
                    isLoading: _isLoading,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
