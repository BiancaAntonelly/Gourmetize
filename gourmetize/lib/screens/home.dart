import 'package:flutter/material.dart';
import 'package:gourmetize/widgets/app_drawer.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/widgets/styled_text.dart';
import 'package:gourmetize/widgets/receita_card.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<Receita> _receitas = [
    Receita(
      id: 1,
      nome: 'Bolo de cenoura',
      descricao: 'Bolo de cenoura com cobertura de chocolate',
      ingredientes:
          '1 Cenoura \n 2kg farinha de trigo \n 500G de açúcar \n 4 ovos \n 1l óleo \n 100g manteiga \n 1l leite',
    ),
    Receita(
      id: 2,
      nome: 'Bolo de chocolate',
      descricao: 'Bolo de chocolate com cobertura de chocolate',
      ingredientes:
          '1kg de chocolate \n 2kg farinha de trigo \n 500G de açúcar \n 4 ovos \n 1l óleo \n 100g manteiga \n 1l leite',
    ),
    Receita(
      id: 3,
      nome: 'Bolo de laranja',
      descricao: 'Bolo de laranja com cobertura de chocolate',
      ingredientes:
          '1 laranja \n 2kg farinha de trigo \n 500G de açúcar \n 4 ovos \n 1l óleo \n 100g manteiga \n 1l leite',
    ),
     Receita(
      id: 4,
      nome: 'Bolo de laranja',
      descricao: 'Bolo de laranja com cobertura de chocolate',
      ingredientes:
          '1 laranja \n 2kg farinha de trigo \n 500G de açúcar \n 4 ovos \n 1l óleo \n 100g manteiga \n 1l leite',
    ),
     Receita(
      id: 5,
      nome: 'Bolo de laranja 2',
      descricao: 'Bolo de laranja com cobertura de chocolate',
      ingredientes:
          '1 laranja \n 2kg farinha de trigo \n 500G de açúcar \n 4 ovos \n 1l óleo \n 100g manteiga \n 1l leite',
    ),
     Receita(
      id: 6,
      nome: 'Bolo de laranja 3',
      descricao: 'Bolo de laranja com cobertura de chocolate',
      ingredientes:
          '1 laranja \n 2kg farinha de trigo \n 500G de açúcar \n 4 ovos \n 1l óleo \n 100g manteiga \n 1l leite',
    ),
  ];


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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
            ),
            const Text(
              'Olá, Fulano! Que bom que você está de volta!',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const StyledText(title: "Receitas"),
            const SizedBox(height: 16), // Espaçamento entre o título e a lista
            _receitas.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma receita disponível.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : Expanded(
                    // O Expanded permite que o ListView ocupe o espaço restante
                    child: ListView.builder(
                      itemCount: _receitas.length,
                      itemBuilder: (ctx, index) {
                        final receita = _receitas[index];
                        return ReceitaCard(receita: receita);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
