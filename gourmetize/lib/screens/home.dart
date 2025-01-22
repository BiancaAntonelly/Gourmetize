import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/receita.dart';
import '../provider/auth_provider.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';
import '../provider/receita_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  String _query = "";
  bool _isLoading = true;

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
      // Filtra baseado no título, descrição, nome dos ingredientes ou nas etiquetas
      return receita.titulo.toLowerCase().contains(_query) ||
          receita.descricao.toLowerCase().contains(_query) ||
          receita.ingredientes.any((ingrediente) => ingrediente.ingredient
              .toLowerCase()
              .contains(_query)) || // Verifica o nome do ingrediente
          receita.etiquetas
              .any((item) => item.nome.toLowerCase().contains(_query));
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
              child: ListaReceitas(
                pertencemAoUsuario: false,
                receitas: receitasFiltradas,
                isLoading: _isLoading,
              ),
            ),
            const SizedBox(height: 16),
            // Exibindo o player do YouTube
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
