import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:gourmetize/provider/avaliacao_provider.dart';
import 'package:gourmetize/provider/carrinho_provider.dart';
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

  VisualizarReceita({
    super.key,
    required this.receita,
  });

  @override
  State<StatefulWidget> createState() => _VisualizarReceitaState();
}

class _VisualizarReceitaState extends State<VisualizarReceita>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Receita _receita;
  int _selectedTabIndex = 0;
  bool _isLoadingAvaliacoes = true;
  List<String> _carrinho = [];
  late Usuario usuarioLogado;
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
    usuarioLogado =
        Provider.of<AuthProvider>(context, listen: false).usuarioLogado!;

    _carregarAvaliacoes(); // Adiciona a chamada para carregar as avaliações
  }

  void _carregarAvaliacoes() {
    final avaliacaoProvider =
        Provider.of<AvaliacaoProvider>(context, listen: false);

    avaliacaoProvider.getAvaliacoes(widget.receita.id).then((value) {
      setState(() {
        _isLoadingAvaliacoes = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void openAvaliacao() {
    final avaliacao = Provider.of<AvaliacaoProvider>(context, listen: false)
        .avaliacoes
        .where((item) => item.usuario.id == usuarioLogado.id)
        .firstOrNull;

    showModalBottomSheet(
      context: context,
      builder: (context) => NovaAvaliacao(
        receita: _receita,
        avaliacao: avaliacao,
      ),
      backgroundColor: Colors.transparent,
    );
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
    final avaliacoes = Provider.of<AvaliacaoProvider>(context).avaliacoes;

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _receita.ingredientes
                            .split('\n')
                            .map((ingrediente) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2), // Menor espaçamento
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ingrediente,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      if (usuarioLogado.id !=
                                          _receita.usuario.id)
                                        IconButton(
                                          icon: Icon(Icons.add_shopping_cart),
                                          onPressed: () =>
                                              _adicionarAoCarrinho(ingrediente),
                                        )
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
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
                      _isLoadingAvaliacoes
                          ? Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : avaliacoes.isEmpty
                              ? const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Nenhuma avaliação disponível.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: avaliacoes.length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        AvaliacaoCard(
                                          avaliacao: avaliacoes[index],
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
      floatingActionButton: usuarioLogado.id == _receita.usuario.id
          ? (_selectedTabIndex == 0
              ? FloatingActionButton(
                  onPressed: _openEditar,
                  child: Icon(Icons.edit,
                      color: Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                )
              : FloatingActionButton(
                  onPressed: _abrirCarrinho,
                  child: Icon(Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ))
          : (_selectedTabIndex == 1 && !_isLoadingAvaliacoes
              ? FloatingActionButton(
                  onPressed: openAvaliacao,
                  child: Icon(Icons.star,
                      color: Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                )
              : FloatingActionButton(
                  onPressed: _abrirCarrinho,
                  child: Icon(Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.secondary),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                )),
    );
  }

  void _adicionarAoCarrinho(String ingrediente) {
    final usuarioId = usuarioLogado.id.toString(); // Identificador do usuário

    // Adiciona o ingrediente ao carrinho
    Provider.of<CarrinhoProvider>(context, listen: false)
        .adicionarIngrediente(ingrediente, usuarioLogado)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$ingrediente adicionado ao carrinho!')),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar ingrediente: $e')),
      );
    });
  }

  void _removerDoCarrinho(String ingrediente) {
    Provider.of<CarrinhoProvider>(context, listen: false)
        .removerIngrediente(ingrediente)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$ingrediente removido do carrinho!')),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover ingrediente: $e')),
      );
    });
  }

  void _abrirCarrinho() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final carrinho = Provider.of<CarrinhoProvider>(context);

        return FutureBuilder(
          future: carrinho.fetchCarrinho("usuarioId"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erro ao carregar o carrinho.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            final ingredientes = carrinho.carrinho?.ingredientes ?? [];

            return Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                // Permite a rolagem
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StyledText(title: 'Carrinho de Compras'),
                    if (ingredientes.isEmpty) ...[
                      SizedBox(height: 20), // Espaçamento entre os elementos
                      Center(
                        child: Text(
                          'Seu carrinho está vazio.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ] else
                      ...ingredientes.map((item) {
                        return ListTile(
                          title: Text(item, style: TextStyle(fontSize: 18)),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () => carrinho.removerIngrediente(item),
                          ),
                        );
                      }).toList(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
