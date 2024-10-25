import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';

class ReceitaCard extends StatelessWidget {

  final Receita _receita;

  const ReceitaCard({super.key, required Receita receita}) : _receita = receita;

  @override
  Widget build(BuildContext context) {
    
    return (
      Card(
        child: ListTile(
          title: Text(_receita.nome),
          subtitle: Text(_receita.descricao),
          isThreeLine: true,
          
          onTap: () {
            // Ação ao clicar na receita
          },
      
       ),
      )
    );
  }

  
}