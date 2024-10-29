import 'package:flutter/material.dart';
import '../model/etiqueta.dart';
import '../model/receita.dart';
import '../model/usuario.dart';
import '../widgets/app_drawer.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';

class Home extends StatefulWidget {
  final List<Receita> receitas;
  final Usuario usuarioLogado;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  Home({
    super.key,
    required this.receitas,
    required this.usuarioLogado,
    required this.onCadastrarReceita,
    required this.onCriarEtiqueta,
  });

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
              'Bem-vindo ao Gourmetize',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            // Corrigido para acessar o nome do usuário logado
            Text(
              'Olá, ${widget.usuarioLogado.nome}! Que bom que você está de volta!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const StyledText(title: "Receitas"),
            const SizedBox(height: 16), // Espaçamento entre o título e a lista
            ListaReceitas(
              usuarioLogado: widget.usuarioLogado,
              onCadastrarReceita: widget.onCadastrarReceita,
              onCriarEtiqueta: widget.onCriarEtiqueta,
              receitas: widget.receitas,
              deleteReceita: _deleteReceita,
              pertencemAoUsuario: false,
            ),
          ],
        ),
      ),
    );
  }
}
