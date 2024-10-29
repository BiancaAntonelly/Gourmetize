import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';

class EtiquetasReceita extends StatelessWidget {
  final Receita receita;

  EtiquetasReceita({required this.receita});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: receita.etiquetas.map((tag) {
        return ChoiceChip(
          label: Text(
            tag.nome,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 12),
          ),
          selected: false,
          showCheckmark: false,
          backgroundColor: Colors.white,
          selectedColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(0),
          onSelected: (value) {},
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        );
      }).toList(),
    );
  }
}
