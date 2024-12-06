import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/etiqueta.dart';
import '../model/receita.dart';
import '../provider/auth_provider.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';
import '../provider/receita_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final void Function(Receita) onCadastrarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  Home({
    super.key,
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
    _searchController.addListener(_filterReceitas);
    final usuarioLogado = Provider.of<AuthProvider>(context, listen: false).usuarioLogado!;
    context.read<ReceitaProvider>().buscarReceitas(usuarioLogado);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterReceitas() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _receitasFiltradas = context.read<ReceitaProvider>().receitas.where((receita) {
        return receita.titulo.toLowerCase().contains(query) ||
            receita.descricao.toLowerCase().contains(query) ||
            receita.ingredientes.toLowerCase().contains(query) ||
            receita.etiquetas.any((item) => item.nome.toLowerCase().contains(query));
      }).toList();
    });
  }

  void _deleteReceita(Receita receita) {
    setState(() {
      context.read<ReceitaProvider>().removerReceita(receita); // Deleta a receita
      _filterReceitas(); // Atualiza a lista filtrada após deletar
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = Provider.of<AuthProvider>(context).usuarioLogado;

    if (usuarioLogado == null) {
      return Center(child: Text('Usuário não está logado'));
    }

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
            const SizedBox(height: 16),
            Text(
              'Bem-vindo ao Gourmetize',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'Olá, ${usuarioLogado.nome}! Que bom que você está de volta!',
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
              child: Consumer<ReceitaProvider>(
                builder: (context, receitaProvider, child) {
                  _receitasFiltradas = receitaProvider.receitas;
                  return ListaReceitas(
                    usuarioLogado: usuarioLogado,
                    onCadastrarReceita: widget.onCadastrarReceita,
                    onCriarEtiqueta: widget.onCriarEtiqueta,
                    receitas: _receitasFiltradas,
                    deleteReceita: _deleteReceita,
                    pertencemAoUsuario: false,
                  );
                },
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
