import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import '../model/receita.dart';
import '../screens/register_recipe.dart';
import '../widgets/nota_receita.dart';
import 'package:gourmetize/config/app_config.dart';

import '../provider/receita_provider.dart';

class ReceitaCard extends StatefulWidget {
  final Receita receita;
  final bool mostrarOpcoes;
  final bool podeFavoritar;

  const ReceitaCard({
    super.key,
    required this.receita,
    required this.podeFavoritar,
    this.mostrarOpcoes = false,
  });

  @override
  _ReceitaCardState createState() => _ReceitaCardState();
}

class _ReceitaCardState extends State<ReceitaCard> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleFavorito() {
    Provider.of<ReceitaProvider>(context, listen: false).toggleFavorita(
      widget.receita,
      Provider.of<AuthProvider>(context, listen: false).usuarioLogado!,
    );
  }

  List<String> _obterIngredientesEmLista() {
    return widget.receita.ingredientes
        .map((ingrediente) => ingrediente.ingredient)
        .toList();
  }

  String _getImageUrl() {
    return AppConfig.minioUrl + widget.receita.imageUrl;
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
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
                  text: widget.receita.titulo,
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
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Deletar', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                try {
                  await Provider.of<ReceitaProvider>(context, listen: false)
                      .removerReceita(widget.receita);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Receita deletada com sucesso!')),
                  );
                } catch (error) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao deletar a receita: $error'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        Provider.of<ReceitaProvider>(context).isFavorita(widget.receita);
    final ingredientes = _obterIngredientesEmLista();

    return GestureDetector(
      onTap: () => context.push('/visualizar-receita', extra: widget.receita),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    height: 180,
                    width: double.infinity,
                    image: widget.receita.imageUrl.isEmpty
                        ? AssetImage('assets/receita-meta2.jpeg')
                        : NetworkImage(_getImageUrl()),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.receita.etiquetas.map((etiqueta) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(etiqueta.nome,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            backgroundColor: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 8,
                  child: Text(
                    widget.receita.titulo,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 5,
                    left: 0,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 8, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [NotaReceita(receita: widget.receita)],
                      ),
                    )),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Row(
                    children: [
                      if (widget.mostrarOpcoes)
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.yellow),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterRevenue(
                                  receitaParaEdicao: widget.receita,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (widget.mostrarOpcoes)
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _showDeleteConfirmationDialog(context),
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (widget.podeFavoritar)
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: _toggleFavorito,
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            // Ingredientes
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ingredientes.map((ingrediente) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text(ingrediente,
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Descrição
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.receita.descricao,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
