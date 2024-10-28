import 'package:flutter/material.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/widgets/app_drawer.dart';
import 'package:gourmetize/widgets/avaliacao_card.dart';
import 'package:gourmetize/widgets/nova_avaliacao.dart';
import 'package:go_router/go_router.dart';

class Avaliacoes extends StatefulWidget {
  final Receita receita;

  Avaliacoes({super.key, required this.receita});

  @override
  State<StatefulWidget> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<Avaliacoes> {
  void _addAvaliacao(Avaliacao avaliacao) {
    setState(() {
      widget.receita.avaliacoes.add(avaliacao);
    });

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    void openNovaAvaliacao() {
      showModalBottomSheet(
        context: context,
        builder: (context) => NovaAvaliacao(
          onSubmit: _addAvaliacao,
        ),
        backgroundColor: Colors.transparent,
      );
    }

    return AppDrawer(
      title: 'Avaliações',
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.receita.avaliacoes.length,
                itemBuilder: (context, index) =>
                    AvaliacaoCard(avaliacao: widget.receita.avaliacoes[index]),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNovaAvaliacao,
        child: Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
