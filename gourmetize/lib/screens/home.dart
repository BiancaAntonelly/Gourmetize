import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/receita.dart';
import '../provider/auth_provider.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';
import '../provider/receita_provider.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  String _query = "";
  bool _isLoading = true;

  List<String> _selectedIngredientes = [];
  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.toLowerCase();
      });
    });

    final usuarioLogado =
        Provider.of<AuthProvider>(context, listen: false).usuarioLogado!;
    context.read<ReceitaProvider>().buscarReceitas(usuarioLogado).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Receita> _filterReceitas(List<Receita> receitas) {
    return receitas.where((receita) {
      final matchesSearch = receita.titulo.toLowerCase().contains(_query) ||
          receita.descricao.toLowerCase().contains(_query) ||
          receita.etiquetas
              .any((item) => item.nome.toLowerCase().contains(_query));

      final matchesIngredientes = _selectedIngredientes.every((ingrediente) =>
          receita.ingredientes.any((item) => item.ingredient == ingrediente));

      return matchesSearch && matchesIngredientes;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final receitasFiltradas =
        _filterReceitas(Provider.of<ReceitaProvider>(context).receitas);
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
            MultiSelectDialogField(
              items: Provider.of<ReceitaProvider>(context)
                  .receitas
                  .expand((receita) => receita.ingredientes
                      .map((ingrediente) => ingrediente.ingredient))
                  .toSet()
                  .toList()
                  .map((ingredient) => MultiSelectItem(ingredient, ingredient))
                  .toList(),
              title: Text("Ingredientes"),
              selectedColor: Theme.of(context).colorScheme.primary,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              buttonText: Text(
                "Selecionar Ingredientes",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onConfirm: (values) {
                setState(() {
                  _selectedIngredientes = List<String>.from(values);
                });
              },
              cancelText: Text('Cancelar'),
            ),
            const SizedBox(height: 20),
            const StyledText(title: "Receitas"),
            const SizedBox(height: 16),
            Expanded(
              child: ListaReceitas(
                pertencemAoUsuario: false,
                receitas: receitasFiltradas,
                isLoading: _isLoading,
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
