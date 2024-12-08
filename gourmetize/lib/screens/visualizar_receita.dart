import 'package:flutter/material.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/provider/avaliacao_provider.dart';
import 'package:gourmetize/widgets/etiquetas_receita.dart';
import 'package:gourmetize/widgets/page_wrapper.dart';
import 'package:gourmetize/widgets/avaliacao_card.dart';
import 'package:gourmetize/widgets/nota_receita.dart';
import 'package:gourmetize/widgets/nova_avaliacao.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/styled_text.dart';
import 'package:provider/provider.dart';

class VisualizarReceita extends StatefulWidget {
  final Receita receita;
  final Usuario usuarioLogado;

  VisualizarReceita({
    super.key,
    required this.receita,
    required this.usuarioLogado,
  });

  @override
  State<StatefulWidget> createState() => _VisualizarReceitaState();
}

class _VisualizarReceitaState extends State<VisualizarReceita>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Receita _receita;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _receita = widget.receita;
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });

    _carregarAvaliacoes(); // Adiciona a chamada para carregar as avaliações
  }

  Future<void> _carregarAvaliacoes() async {
    final avaliacaoProvider =
        Provider.of<AvaliacaoProvider>(context, listen: false);

    final avaliacoes =
        await avaliacaoProvider.getAvaliacoesPorReceita(_receita.id ?? 0);
    print(
        'Avaliações carregadas: $avaliacoes'); // Debug: Verifica os dados carregados

    setState(() {
      _receita.avaliacoes = avaliacoes;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addAvaliacao(Avaliacao avaliacao) {
    setState(() {
      _receita.avaliacoes.add(avaliacao);
    });

    context.pop();
  }

  void openNovaAvaliacao() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NovaAvaliacao(
        receita: _receita,
      ),
      backgroundColor: Colors.transparent,
    );
  }

  bool get _ususarioHasAvaliacao {
    return _receita.avaliacoes
        .where((avaliacao) => avaliacao.usuario.id == widget.usuarioLogado.id)
        .isNotEmpty;
  }

  void _openEditar() async {
    Receita? receita =
        await context.push<Receita>("/editar-receita", extra: _receita);

    if (receita != null) {
      setState(() {
        _receita = receita;
      });
    }
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
                      Text(
                        _receita.titulo,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "Enviado por ${_receita.usuario.nome}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        child: NotaReceita(receita: _receita),
                        onTap: () {
                          _tabController.animateTo(1);
                        },
                      ),
                      SizedBox(height: 20),
                      StyledText(title: 'Descrição'),
                      Text(
                        _receita.descricao,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      StyledText(title: 'Ingredientes'),
                      Text(_receita.ingredientes,
                          style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                      StyledText(title: 'Modo de preparo'),
                      Text(_receita.preparo, style: TextStyle(fontSize: 18)),
                      SizedBox(height: 20),
                      if (_receita.etiquetas.length > 0)
                        StyledText(title: 'Etiquetas'),
                      if (_receita.etiquetas.length > 0)
                        EtiquetasReceita(receita: _receita)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      StyledText(title: 'Avaliações'),
                      SizedBox(height: 20),
                      _receita.avaliacoes.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhuma avaliação disponível.',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: _receita.avaliacoes.length,
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    AvaliacaoCard(
                                      avaliacao: _receita.avaliacoes[index],
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
      floatingActionButton: widget.usuarioLogado.id == _receita.usuario.id
          ? (_selectedTabIndex == 0
              ? (FloatingActionButton(
                  onPressed: _openEditar,
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
