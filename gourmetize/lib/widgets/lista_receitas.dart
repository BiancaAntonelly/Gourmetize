import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/widgets/receita_card.dart';

class ListaReceitas extends StatefulWidget {
  final bool pertencemAoUsuario;
  final List<Receita> receitas;
  final bool isLoading;

  ListaReceitas(
      {required this.pertencemAoUsuario,
      required this.receitas,
      this.isLoading = false});

  @override
  State<StatefulWidget> createState() => _ListaReceitasState();
}

class _ListaReceitasState extends State<ListaReceitas> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // Se a lista de receitas estiver vazia, exibe a mensagem
    if (widget.receitas.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma receita disponível.',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    // Caso contrário, exibe a lista de receitas filtradas
    return ListView.builder(
      itemCount: widget.receitas.length,
      itemBuilder: (ctx, index) {
        final receita = widget.receitas[index];
        return ReceitaCard(
          receita: receita,
          podeFavoritar: true,
          mostrarOpcoes: widget.pertencemAoUsuario,
        );
      },
    );
  }
}
