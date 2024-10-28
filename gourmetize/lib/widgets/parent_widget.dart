import 'package:flutter/material.dart';
import 'package:gourmetize/screens/register_revenue.dart';

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  List<Map<String, String>> receitas = [];

  // Função para adicionar receita
  void adicionarReceita(String titulo, String ingredientes, String descricao, String preparo) {
    setState(() {
      receitas.add({
        'titulo': titulo,
        'ingredientes': ingredientes,
        'descricao': descricao,
        'preparo': preparo,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Receitas')),
      body: RegisterRevenue(
        onCadastrarReceita: adicionarReceita, // Passando a função para o widget filho
      ),
    );
  }
}
