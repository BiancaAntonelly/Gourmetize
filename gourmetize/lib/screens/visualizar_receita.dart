import 'package:flutter/material.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/widgets/etiquetas_receita.dart';
import 'package:gourmetize/widgets/page_wrapper.dart';
import 'package:gourmetize/widgets/avaliacao_card.dart';
import 'package:gourmetize/widgets/nota_receita.dart';
import 'package:gourmetize/widgets/nova_avaliacao.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/styled_text.dart';

class VisualizarReceita extends StatefulWidget {
  final Receita receita;
  final Usuario usuarioLogado;

  VisualizarReceita(
      {super.key, required this.receita, required this.usuarioLogado});

  @override
  State<StatefulWidget> createState() => _VisualizarReceitaState();
}

class _VisualizarReceitaState extends State<VisualizarReceita>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addAvaliacao(Avaliacao avaliacao) {
    setState(() {
      widget.receita.avaliacoes.add(avaliacao);
    });

    context.pop();
  }

  void openNovaAvaliacao() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NovaAvaliacao(
        onSubmit: _addAvaliacao,
      ),
      backgroundColor: Colors.transparent,
    );
  }

  bool get _ususarioHasAvaliacao {
    return widget.receita.avaliacoes
        .where((avaliacao) => avaliacao.usuario.id == widget.usuarioLogado.id)
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Receita',
      pageWrapperButtonType: PageWrapperButtonType.back,
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.red,
            tabs: [
              Tab(text: 'Detalhes'),
              Tab(text: 'Avaliações'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/receita-meta2.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.receita.titulo,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          NotaReceita(receita: widget.receita)
                        ],
                      ),
                      SizedBox(height: 20),
                      StyledText(title: 'Descrição'),
                      Text(
                        widget.receita.descricao,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      StyledText(title: 'Ingredientes'),
                      Text(widget.receita.ingredientes,
                          style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                      StyledText(title: 'Modo de preparo'),
                      Text(widget.receita.preparo,
                          style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                      if (widget.receita.etiquetas.length > 0)
                        StyledText(title: 'Etiquetas'),
                      if (widget.receita.etiquetas.length > 0)
                        EtiquetasReceita(receita: widget.receita)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      StyledText(title: 'Avaliações'),
                      SizedBox(height: 20),
                      widget.receita.avaliacoes.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhuma avaliação disponível.',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: widget.receita.avaliacoes.length,
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    AvaliacaoCard(
                                      avaliacao:
                                          widget.receita.avaliacoes[index],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    )
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.usuarioLogado.id == widget.receita.usuario.id
          ? (_selectedTabIndex == 0
              ? (FloatingActionButton(
                  onPressed: () {
                    context.push("/editar-receita", extra: widget.receita);
                  },
                  child: Icon(Icons.edit,
                      color: Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ))
              : null)
          : (_selectedTabIndex == 1 && !_ususarioHasAvaliacao
              ? FloatingActionButton(
                  onPressed: openNovaAvaliacao,
                  child: Icon(Icons.star,
                      color: Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                )
              : null),
    );
  }
}
