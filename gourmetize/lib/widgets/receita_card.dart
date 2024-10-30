import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/etiquetas_receita.dart';
import 'package:gourmetize/widgets/nota_receita.dart';

import '../model/etiqueta.dart';
import '../model/usuario.dart';
import '../screens/register_recipe.dart';

class ReceitaCard extends StatelessWidget {
  final Receita _receita;
  final VoidCallback? onDelete;
  final bool mostrarOpcoes;
  final Usuario usuarioLogado;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  const ReceitaCard({
    super.key,
    required Receita receita,
    this.onDelete,
    required this.usuarioLogado,
    required this.onCadastrarReceita,
    required this.onCriarEtiqueta,
    this.mostrarOpcoes = false,
  }) : _receita = receita;

  List<String> _obterIngredientesEmLista() {
    return _receita.ingredientes
        .split('\n')
        .map((ingrediente) => '- $ingrediente')
        .toList();
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Impede que o modal seja fechado ao tocar fora dele
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              const SizedBox(width: 10),
              Text(
                'Deletar receita',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 16),
              children: [
                const TextSpan(
                    text: 'Você tem certeza que deseja deletar a receita '),
                TextSpan(
                  text: _receita.titulo, // Adicionando o título da receita aqui
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const TextSpan(text: '? Esta ação não pode ser desfeita.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal
              },
            ),
            TextButton(
              child: const Text(
                'Deletar',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                if (onDelete != null) onDelete!();
                Navigator.of(context).pop(); // Fecha o modal após deletar
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ingredientes = _obterIngredientesEmLista();

    return GestureDetector(
      onTap: () {
        context.push('/visualizar-receita', extra: _receita);
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/receita-meta2.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    _receita.titulo.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: 
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  if (mostrarOpcoes)
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          _showDeleteConfirmationDialog(
                                              context),
                                      tooltip: 'Deletar receita',
                                      color: Colors.red,
                                    ),
                                  if (mostrarOpcoes)
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterRevenue(
                                              usuarioLogado: usuarioLogado,
                                              onCadastrarReceita:
                                                  onCadastrarReceita,
                                              onCriarEtiqueta: onCriarEtiqueta,
                                              receitaParaEdicao:
                                                  _receita, // passa a receita para edição
                                            ),
                                          ),
                                        );
                                      },
                                      tooltip: 'Editar receita',
                                      color: Colors.yellow,
                                    ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: IngredientesGrid(ingredientes: ingredientes),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [NotaReceita(receita: _receita)],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [EtiquetasReceita(receita: _receita)],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 4, left: 10, right: 10),
                      child: Text(
                        _receita.descricao,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientesGrid extends StatelessWidget {
  final List<String> ingredientes;

  const IngredientesGrid({super.key, required this.ingredientes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5,
      ),
      itemCount: ingredientes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            ingredientes[index],
            style: const TextStyle(
                color: Color.fromRGBO(230, 193, 11, 100), fontSize: 12),
          ),
        );
      },
    );
  }
}
