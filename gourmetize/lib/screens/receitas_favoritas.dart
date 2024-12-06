import 'package:flutter/material.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../model/etiqueta.dart';
import '../model/receita.dart';
import '../model/usuario.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';

class ReceitasFavoritas extends StatefulWidget {
  final List<Receita> receitas;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Receita) onDeletarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  ReceitasFavoritas({
    super.key,
    required this.receitas,
    required this.onCadastrarReceita,
    required this.onDeletarReceita,
    required this.onCriarEtiqueta,
  });

  @override
  _ReceitasFavoritasState createState() => _ReceitasFavoritasState();
}

class _ReceitasFavoritasState extends State<ReceitasFavoritas> {
  @override
  Widget build(BuildContext context) {

    final usuarioLogado = Provider.of<AuthProvider>(context).usuarioLogado!;

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
              child: ListaReceitas(
                usuarioLogado: usuarioLogado,
                onCadastrarReceita: widget.onCadastrarReceita,
                onCriarEtiqueta: widget.onCriarEtiqueta,
                receitas: usuarioLogado.receitas,
                deleteReceita: widget.onDeletarReceita,
                pertencemAoUsuario: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
