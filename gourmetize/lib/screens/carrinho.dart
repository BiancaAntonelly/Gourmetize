import 'package:flutter/material.dart';
import 'package:gourmetize/provider/carrinho_provider.dart';
import 'package:provider/provider.dart';
class CarrinhoPage extends StatelessWidget {
  const CarrinhoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final carrinhoProvider = Provider.of<CarrinhoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Carrinho',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(255, 204, 0, 100),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              _limparCarrinho(context, carrinhoProvider);
            },
            tooltip: 'Limpar Carrinho',
          ),
        ],
      ),
      body: FutureBuilder(
        future: carrinhoProvider.fetchCarrinho('usuarioId'), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar o carrinho.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final ingredientes = carrinhoProvider.carrinho?.ingredientes ?? [];

          if (ingredientes.isEmpty) {
            return const Center(
              child: Text(
                'Seu carrinho está vazio.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: ingredientes.length,
            itemBuilder: (context, index) {
              final ingrediente = ingredientes[index];
              return ListTile(
                title: Text('${index + 1}   $ingrediente', style: const TextStyle(fontSize: 18)), // Exibe a numeração
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  color: Colors.red,
                  onPressed: () => _removerDoCarrinho(context, carrinhoProvider, ingrediente),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _limparCarrinho(context, carrinhoProvider); // Limpa o carrinho ao pressionar o botão
        },
        label: const Text('Limpar Carrinho'),
        icon: const Icon(Icons.delete),
        backgroundColor: const Color.fromRGBO(255, 204, 0, 100),
      ),
    );
  }

  void _removerDoCarrinho(BuildContext context, CarrinhoProvider provider, String ingrediente) {
    provider.removerIngrediente(ingrediente).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$ingrediente removido do carrinho!')),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover ingrediente: $e')),
      );
    });
  }

  void _limparCarrinho(BuildContext context, CarrinhoProvider provider) {
    provider.limparCarrinho().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Carrinho limpo com sucesso!')),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao limpar carrinho: $e')),
      );
    });
  }
}
