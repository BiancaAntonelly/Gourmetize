import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/etiqueta.dart';
import '../model/receita.dart';
import '../model/usuario.dart';
import '../widgets/page_wrapper.dart';
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
  final TextEditingController _searchController = TextEditingController();
  late List<Receita> _receitasFiltradas;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _receitasFiltradas = widget.receitas;

    _searchController.addListener(_filterReceitas);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterReceitas() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _receitasFiltradas = widget.receitas.where((receita) {
        return receita.titulo.toLowerCase().contains(query) ||
            receita.descricao.toLowerCase().contains(query) ||
            receita.ingredientes.toLowerCase().contains(query) ||
            receita.etiquetas
                .any((item) => item.nome.toLowerCase().contains(query));
      }).toList();
    });
  }

  void _deleteReceita(Receita receita) {
    setState(() {
      widget.receitas.remove(receita);
      _filterReceitas(); // Atualiza a lista filtrada após deletar
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: '',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar receita',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ), // Espaçamento entre a pesquisa e o texto de boas-vindas
            Text(
              'Bem-vindo ao Gourmetize',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
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
            const SizedBox(height: 16),
            Expanded(
              child: ListaReceitas(
                usuarioLogado: widget.usuarioLogado,
                onCadastrarReceita: widget.onCadastrarReceita,
                onCriarEtiqueta: widget.onCriarEtiqueta,
                receitas: _receitasFiltradas,
                deleteReceita: _deleteReceita,
                pertencemAoUsuario: false,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary),
        onPressed: () {
          context.push('/cadastrar-receita');
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
