import 'package:flutter/material.dart';
import '../model/receita.dart';
import '../widgets/app_drawer.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';

class ReceitasUsuario extends StatefulWidget {
  final List<Receita> receitas;

  ReceitasUsuario({super.key, required this.receitas});

  @override
  _ReceitasUsuarioState createState() => _ReceitasUsuarioState();
}

class _ReceitasUsuarioState extends State<ReceitasUsuario> {
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
            const SizedBox(height: 10),
            const StyledText(title: "Receitas"),
            const SizedBox(height: 16), // Espaçamento entre o título e a lista
            ListaReceitas(
              receitas: widget.receitas,
              deleteReceita: _deleteReceita,
              pertencemAoUsuario: true,
            ),
          ],
        ),
      ),
    );
  }
}
