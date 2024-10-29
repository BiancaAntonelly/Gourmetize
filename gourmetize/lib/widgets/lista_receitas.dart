import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/widgets/receita_card.dart';

import '../model/etiqueta.dart';
import '../model/usuario.dart';

class ListaReceitas extends StatelessWidget {
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
    required this.onCriarEtiqueta,});

  void deletar(Receita receita){
    if(deleteReceita != null){
      deleteReceita!(receita); 
    }
  }

  @override
  Widget build(BuildContext context) {
     return receitas.isEmpty
        ? const Center(
      child: Text(
        'Nenhuma receita disponível.',
        style: TextStyle(fontSize: 18),
      ),
    )
        : Expanded(
      // O Expanded permite que o ListView ocupe o espaço restante
      child: ListView.builder(
        itemCount: receitas.length,
        itemBuilder: (ctx, index) {
          final receita = receitas[index];
          return ReceitaCard(
            receita: receita,
            usuarioLogado: usuarioLogado,
            onCadastrarReceita: onCadastrarReceita,
            onCriarEtiqueta: onCriarEtiqueta,
            onDelete: () => deletar(receita), // Passa a função de deleção
            mostrarOpcoes: pertencemAoUsuario,
          );
        },
      ),
    );
  }
}