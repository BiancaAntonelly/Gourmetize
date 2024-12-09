import 'package:flutter/material.dart';
import 'package:gourmetize/model/carrinho.dart'; // Importando o modelo Carrinho
import 'package:gourmetize/service/carrinho_service.dart'; // Importando o serviço para manipulação do Carrinho

class CarrinhoProvider with ChangeNotifier {
  Carrinho? _carrinho; // Armazenamento do carrinho do usuário
  final CarrinhoService _carrinhoService = CarrinhoService();

  Carrinho? get carrinho => _carrinho; // Getter para acessar o carrinho

  // Método para buscar o carrinho do usuário
  Future<void> fetchCarrinho(String usuarioId) async {
    try {
      _carrinho = await _carrinhoService
          .getCarrinho(usuarioId); // Chama o serviço para buscar o carrinho

      // Garantir que a lista de ingredientes seja inicializada
      _carrinho?.ingredientes ??=
          []; // Inicializa a lista de ingredientes caso seja null

      notifyListeners(); // Notifica os listeners (widgets que dependem do carrinho)
    } catch (e) {
      print("Erro ao buscar carrinho: $e");
    }
  }

  // Método para adicionar um ingrediente ao carrinho
  Future<void> adicionarIngrediente(String ingrediente) async {
    if (_carrinho != null) {
      // Inicializa a lista de ingredientes caso seja null
      _carrinho!.ingredientes ??= [];

      _carrinho!.ingredientes.add(ingrediente); // Adiciona o ingrediente
      await _carrinhoService
          .atualizarCarrinho(_carrinho!); // Atualiza o carrinho no servidor
      notifyListeners(); // Notifica os listeners sobre a atualização
    }
  }

  // Método para limpar o carrinho
  Future<void> limparCarrinho() async {
    if (_carrinho != null) {
      // Inicializa a lista de ingredientes caso seja null
      _carrinho!.ingredientes ??= [];

      _carrinho!.ingredientes.clear(); // Limpa a lista de ingredientes
      await _carrinhoService
          .atualizarCarrinho(_carrinho!); // Atualiza o carrinho no servidor
      notifyListeners(); // Notifica os listeners sobre a atualização
    }
  }

  // Método para remover um ingrediente
  Future<void> removerIngrediente(String ingrediente) async {
    if (_carrinho != null) {
      // Inicializa a lista de ingredientes caso seja null
      _carrinho!.ingredientes ??= [];

      _carrinho!.ingredientes.remove(ingrediente); // Remove o ingrediente
      await _carrinhoService
          .atualizarCarrinho(_carrinho!); // Atualiza o carrinho no servidor
      notifyListeners(); // Notifica os listeners sobre a atualização
    }
  }

  // Método para definir o carrinho (pode ser útil em alguns casos)
  void setCarrinho(Carrinho carrinho) {
    _carrinho = carrinho;
    notifyListeners();
  }
}
