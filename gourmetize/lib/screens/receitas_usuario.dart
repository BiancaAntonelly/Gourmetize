import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../model/etiqueta.dart';
import '../model/receita.dart';
import '../provider/auth_provider.dart';
import '../provider/receita_provider.dart';
import '../widgets/page_wrapper.dart';
import '../widgets/styled_text.dart';
import '../widgets/lista_receitas.dart';
class ReceitasUsuario extends StatefulWidget {
  final List<Receita> receitas;
  final void Function(Receita) onCadastrarReceita;
  final void Function(Receita) onDeletarReceita;
  final void Function(Etiqueta) onCriarEtiqueta;

  ReceitasUsuario({
    super.key,
    required this.receitas,
    required this.onCadastrarReceita,
    required this.onDeletarReceita,
    required this.onCriarEtiqueta,
  });

  @override
  _ReceitasUsuarioState createState() => _ReceitasUsuarioState();
}
class _ReceitasUsuarioState extends State<ReceitasUsuario> {
  bool _isLoading = true;
  late List<Receita> _receitasUser;

  @override
  void initState() {
    _carregarReceitas();
    super.initState();
    _carregarReceitas();
  }


  Future<void> _carregarReceitas() async {
    final usuarioLogado = Provider.of<AuthProvider>(context, listen: false).usuarioLogado!;
    try {
      final receitas = await context.read<ReceitaProvider>().buscarReceitasPorUsuario(usuarioLogado);
      setState(() {
        _receitasUser = receitas;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print("Erro ao carregar receitas do usuário: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = Provider.of<AuthProvider>(context).usuarioLogado;

    if (usuarioLogado == null) {
      return Center(child: Text('Usuário não está logado'));
    }

    return PageWrapper(
      title: '',
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const StyledText(title: "Minhas Receitas"),
            const SizedBox(height: 16),
            Expanded(
              child: ListaReceitas(
                usuarioLogado: usuarioLogado,
                onCadastrarReceita: widget.onCadastrarReceita,
                onCriarEtiqueta: widget.onCriarEtiqueta,
                receitas: _receitasUser,
                deleteReceita: widget.onDeletarReceita,
                pertencemAoUsuario: true,
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
