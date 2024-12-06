import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../model/receita.dart';
import '../model/etiqueta.dart';
import '../model/usuario.dart';
import '../screens/register_recipe.dart';
import '../widgets/nota_receita.dart';

import '../provider/receita_provider.dart';

class ReceitaCard extends StatefulWidget {
  final Receita receita;
  final VoidCallback? onDelete;
  final bool mostrarOpcoes;
  final bool podeFavoritar;
  final Usuario usuarioLogado;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  const ReceitaCard({
    super.key,
    required this.receita,
    this.onDelete,
    required this.usuarioLogado,
    required this.podeFavoritar,
    required this.onCadastrarReceita,
    required this.onCriarEtiqueta,
    this.mostrarOpcoes = false,
  });

  @override
  _ReceitaCardState createState() => _ReceitaCardState();
}

class _ReceitaCardState extends State<ReceitaCard> {

  bool _isFavorited = false;

   @override
  void initState() {
    super.initState();
    _isFavorited = Provider.of<ReceitaProvider>(context, listen: false).isFavorita(widget.receita);
  }

  void _toggleFavorito() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    Provider.of<ReceitaProvider>(context, listen: false).toggleFavorita(widget.receita, widget.usuarioLogado);
  }


  List<String> _obterIngredientesEmLista() {
    return widget.receita.ingredientes.split('\n').toList();
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
              children: [
                const TextSpan(text: 'Você tem certeza que deseja deletar a receita '),
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
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Deletar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                if (widget.onDelete != null) widget.onDelete!();
                Navigator.of(context).pop();
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
      onTap: () => context.push('/visualizar-receita', extra: widget.receita),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Imagem e título sobrepostos
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    'assets/receita-meta2.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
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
                            label: Text(etiqueta.nome, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
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
                          child:  IconButton(
                          icon: const Icon(Icons.edit, color: Colors.yellow),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterRevenue(
                                onCadastrarReceita: widget.onCadastrarReceita,
                                onCriarEtiqueta: widget.onCriarEtiqueta,
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
                          child:  IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteConfirmationDialog(context),
                          ),
                        ),
                      const SizedBox(width: 8),
                        if (widget.podeFavoritar)
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child:  IconButton(
                              icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
                              onPressed:_toggleFavorito,
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
                        label: Text(ingrediente, style: TextStyle(color: Colors.white)),
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
