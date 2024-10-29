import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/etiqueta.dart';
import '../model/receita.dart';
import '../model/usuario.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';

class ReceitasUsuario extends StatefulWidget {
  final List<Receita> receitas;
  final Usuario usuarioLogado;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  ReceitasUsuario({
    super.key,
    required this.receitas,
    required this.usuarioLogado,
    required this.onCadastrarReceita,
    required this.onCriarEtiqueta,
  });

  @override
  _ReceitasUsuarioState createState() => _ReceitasUsuarioState();
}

class _ReceitasUsuarioState extends State<ReceitasUsuario> {
  void _deleteReceita(Receita receita) {
    setState(() {
      widget.receitas.remove(receita);
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
            const StyledText(title: "Minhas Receitas"),
            const SizedBox(height: 16), // Espaçamento entre o título e a lista
            ListaReceitas(
              usuarioLogado: widget.usuarioLogado,
              onCadastrarReceita: widget.onCadastrarReceita,
              onCriarEtiqueta: widget.onCriarEtiqueta,
              receitas: widget.receitas,
              deleteReceita: _deleteReceita,
              pertencemAoUsuario: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary),
        onPressed: () {
          context.push('/cadastrar-receita');
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
