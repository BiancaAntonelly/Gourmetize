import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/screens/visualizar_receita.dart';

class ReceitaCard extends StatelessWidget {
  final Receita _receita;
  final VoidCallback onDelete; // Callback para deleção

  const ReceitaCard({
    super.key,
    required Receita receita,
    required this.onDelete,
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
      barrierDismissible: false, // Usuário deve pressionar um botão para sair
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Deleção'),
          content: const Text('Você tem certeza que deseja deletar esta receita?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: const Text('Deletar'),
              onPressed: () {
                onDelete(); // Chama a função de deleção
                Navigator.of(context).pop(); // Fecha o diálogo
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
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return VisualizarReceita(receita: _receita);
            },
        ));
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
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/receita-meta2.jpeg',
                            fit: BoxFit.cover,
                          ),
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
                                child: Text(
                                  _receita.titulo.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _showDeleteConfirmationDialog(context),
                                tooltip: 'Deletar receita',
                                color: Colors.red,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: IngredientesGrid(ingredientes: ingredientes),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  _receita.descricao,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
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
