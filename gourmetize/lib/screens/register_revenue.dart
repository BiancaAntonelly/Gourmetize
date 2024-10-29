import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/widgets/app_drawer.dart';

class RegisterRevenue extends StatefulWidget {
  final Usuario usuarioLogado;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;
  final Receita? receitaParaEdicao;

  const RegisterRevenue({
    super.key,
    required this.usuarioLogado,
    required this.onCadastrarReceita,
    required this.onCriarEtiqueta,
    this.receitaParaEdicao,
  });
  @override
  _RegisterRevenueState createState() => _RegisterRevenueState();
}

class _RegisterRevenueState extends State<RegisterRevenue> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController ingredientesController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController preparoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Etiqueta> _etiquetas = [];
  final TextEditingController etiquetaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.receitaParaEdicao != null) {
      tituloController.text = widget.receitaParaEdicao!.titulo;
      ingredientesController.text = widget.receitaParaEdicao!.ingredientes;
      descricaoController.text = widget.receitaParaEdicao!.descricao;
      preparoController.text = widget.receitaParaEdicao!.preparo;

      _etiquetas.addAll(widget.receitaParaEdicao!.etiquetas);
    }
  }

  void _addEtiqueta(String nome) {
    if (nome.isEmpty) return;

    Etiqueta etiqueta = Etiqueta(nome: nome, usuario: widget.usuarioLogado);

    setState(() {
      _etiquetas.add(etiqueta);
    });

    widget.onCriarEtiqueta(etiqueta);

    etiquetaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      title: 'Cadastrar Receita',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Título da receita:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: tituloController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Digite o título da sua receita',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O título é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Ingredientes:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: ingredientesController,
                  style: TextStyle(fontSize: 16),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        'Informe os ingredientes separados por uma quebra de linha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Os ingredientes são obrigatórios';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Descrição:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descricaoController,
                  maxLines: 4,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText:
                        'Informe uma breve descrição para ser mostrada na listagem de receitas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A descrição é obrigatória';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Modo de preparo:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: preparoController,
                  style: TextStyle(fontSize: 16),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        'Informe o modo de preparo da sua receita separando os passos por uma quebra de linha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O modo de preparo é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Etiquetas:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: widget.usuarioLogado.etiquetas.map((tag) {
                    return ChoiceChip(
                      label: Text(tag.nome),
                      selected: _etiquetas.contains(tag),
                      backgroundColor: Colors.white,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      onSelected: (selected) {
                        setState(() {
                          selected
                              ? _etiquetas.add(tag)
                              : _etiquetas.remove(tag);
                        });
                      },
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: etiquetaController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Adicione uma etiqueta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                    ),
                  ),
                  onFieldSubmitted: _addEtiqueta,
                ),
                const SizedBox(height: 24),
                Center(
                    child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.receitaParaEdicao != null) {
                        // Atualizar a receita existente
                        widget.onCadastrarReceita(
                          Receita(
                            id: widget.receitaParaEdicao!.id,
                            titulo: tituloController.text,
                            descricao: descricaoController.text,
                            ingredientes: ingredientesController.text,
                            preparo: preparoController.text,
                            usuario: widget.usuarioLogado,
                            etiquetas: _etiquetas,
                          ),
                        );
                      } else {
                        widget.onCadastrarReceita(
                          Receita(
                            id: Random().nextInt(10000),
                            titulo: tituloController.text,
                            descricao: descricaoController.text,
                            ingredientes: ingredientesController.text,
                            preparo: preparoController.text,
                            usuario: widget.usuarioLogado,
                            etiquetas: _etiquetas,
                          ),
                        );
                      }
                      GoRouter.of(context).go('/'); // Redireciona após a ação
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    widget.receitaParaEdicao == null
                        ? 'Cadastrar Receita'
                        : 'Atualizar Receita',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
