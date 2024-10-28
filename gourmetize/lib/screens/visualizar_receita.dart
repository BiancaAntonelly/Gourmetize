import 'package:flutter/material.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/widgets/app_drawer.dart';
import 'package:gourmetize/widgets/avaliacao_card.dart';
import 'package:gourmetize/widgets/nova_avaliacao.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/styled_text.dart';

class VisualizarReceita extends StatefulWidget {
  final Receita receita;

  VisualizarReceita({super.key, required this.receita});

  @override
  State<StatefulWidget> createState() => _VisualizarReceitaState();
}

class _VisualizarReceitaState extends State<VisualizarReceita> {
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

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      title: 'Receita',
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            // Abas de navegação
            TabBar(
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
                children: [
                  // Aba Detalhes
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
                        Center(
                          child: Text(
                            widget.receita.titulo,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        StyledText(title: 'Descrição'),
                        Text(
                          widget.receita.descricao,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        StyledText(title: 'Ingredientes'),
                        Text(widget.receita.ingredientes, style: TextStyle(fontSize: 18)),
                        SizedBox(height: 20),
                        StyledText(title: 'Modo de preparo'),
                        Text(widget.receita.preparo, style: TextStyle(fontSize: 18)),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  // Aba Avaliações
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.receita.avaliacoes.length,
                          itemBuilder: (context, index) =>
                              AvaliacaoCard(avaliacao: widget.receita.avaliacoes[index]),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: openNovaAvaliacao,
                        child: Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
