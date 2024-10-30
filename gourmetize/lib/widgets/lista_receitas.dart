import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/widgets/receita_card.dart';

import '../model/etiqueta.dart';
import '../model/usuario.dart';

class ListaReceitas extends StatefulWidget {
  final List<Receita> receitas;
  final void Function(Receita receita)? deleteReceita;
  final bool pertencemAoUsuario;
  final Usuario usuarioLogado;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  ListaReceitas({
    required this.receitas,
    this.deleteReceita,
    required this.pertencemAoUsuario,
    required this.usuarioLogado,
    required this.onCadastrarReceita,
    required this.onCriarEtiqueta,
  });

  @override
  State<StatefulWidget> createState() => _ListaReceitasState();
}

class _ListaReceitasState extends State<ListaReceitas> {

  void onDeletarReceita(Receita receita) {
    if (widget.deleteReceita != null) {
      widget.deleteReceita!(receita);
    }
  }

  void onCadastrarReceita(Receita receita) {
    widget.onCadastrarReceita(receita);
  }

  @override
  Widget build(BuildContext context) {
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
          usuarioLogado: widget.usuarioLogado,
          onCadastrarReceita: onCadastrarReceita,
          onCriarEtiqueta: widget.onCriarEtiqueta,
          onDelete: () => onDeletarReceita(receita), // Passa a função de deleção
          mostrarOpcoes: widget.pertencemAoUsuario,
        );
      },
    );
  }
}
