import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/receita.dart';
import '../widgets/app_drawer.dart';
import '../widgets/receita_card.dart';
import '../widgets/styled_text.dart';

class Home extends StatefulWidget {
  final List<Receita> receitas;

  Home({super.key, required this.receitas});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _deleteReceita(Receita receita) {
    setState(() {
      widget.receitas.remove(receita);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      title: '',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem vindos ao Gourmetize',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Text(
              'Olá, Fulano! Que bom que você está de volta!',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const StyledText(title: "Receitas"),
            const SizedBox(height: 16), // Espaçamento entre o título e a lista
            widget.receitas.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma receita disponível.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Expanded(
                    // O Expanded permite que o ListView ocupe o espaço restante
                    child: ListView.builder(
                      itemCount: widget.receitas.length,
                      itemBuilder: (ctx, index) {
                        final receita = widget.receitas[index];
                        return ReceitaCard(
                          receita: receita,
                          onDelete: () => _deleteReceita(
                              receita), // Passa a função de deleção
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
