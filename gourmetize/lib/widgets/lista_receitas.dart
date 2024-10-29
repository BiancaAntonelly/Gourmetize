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
  late List<Receita> _receitas;

  @override
  void initState() {
    super.initState();

    _receitas = widget.receitas;
  }

  void onDeletarReceita(Receita receita) {
    setState(() {
      _receitas.removeWhere((item) => item.id == receita.id);
    });

    if (widget.deleteReceita != null) {
      widget.deleteReceita!(receita);
    }
  }

  void onCadastrarReceita(Receita receita) {
    int receitaIndex = _receitas.indexWhere((item) => item.id == receita.id);

    if (receitaIndex == -1) {
      setState(() {
        _receitas.add(receita);
      });
    } else {
      setState(() {
        _receitas[receitaIndex] = receita;
      });
    }

    widget.onCadastrarReceita(receita);
  }

  @override
  Widget build(BuildContext context) {
    return _receitas.isEmpty
        ? const Center(
            child: Text(
              'Nenhuma receita disponível.',
              style: TextStyle(fontSize: 18),
            ),
          )
        : Expanded(
            // O Expanded permite que o ListView ocupe o espaço restante
            child: ListView.builder(
              itemCount: _receitas.length,
              itemBuilder: (ctx, index) {
                final receita = _receitas[index];
                return ReceitaCard(
                  receita: receita,
                  usuarioLogado: widget.usuarioLogado,
                  onCadastrarReceita: onCadastrarReceita,
                  onCriarEtiqueta: widget.onCriarEtiqueta,
                  onDelete: () =>
                      onDeletarReceita(receita), // Passa a função de deleção
                  mostrarOpcoes: widget.pertencemAoUsuario,
                );
              },
            ),
          );
  }
}
