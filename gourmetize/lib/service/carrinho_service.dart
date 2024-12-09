import 'dart:convert';
import 'package:gourmetize/config/app_config.dart';
import 'package:gourmetize/model/carrinho.dart';
import 'package:http/http.dart' as http;
import 'package:gourmetize/config/app_config.dart';
import 'dart:convert';
import 'package:gourmetize/config/app_config.dart';
import 'package:gourmetize/model/carrinho.dart';
import 'package:http/http.dart' as http;

class CarrinhoService {
  final String _baseUrl = AppConfig.baseUrl + '/carrinho';

  // Método para buscar o carrinho do usuário
  Future<Carrinho> getCarrinho(String usuarioId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$usuarioId'));

    if (response.statusCode == 200) {
      return Carrinho.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao buscar carrinho');
    }
  }

  // Método para atualizar o carrinho no backend
  Future<void> atualizarCarrinho(Carrinho carrinho) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${carrinho.usuario.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(carrinho.toJson()),
      );

      if (response.statusCode == 200) {
        print('Carrinho atualizado com sucesso.');
      } else {
        print(
            'Erro ao atualizar carrinho: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Erro de rede: $e');
    }
  }

  // Método para limpar o carrinho
  Future<void> limparCarrinho(String usuarioId) async {
    final response = await http.put(
      Uri.parse(
          '$_baseUrl/limpar/$usuarioId'), // Assumindo que no backend você tem um endpoint para limpar o carrinho
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao limpar carrinho');
    }
  }

  // Método para adicionar um ingrediente ao carrinho
  Future<void> adicionarIngrediente(
      Carrinho carrinho, String ingrediente) async {
    carrinho.ingredientes.add(ingrediente); // Adiciona o ingrediente
    await atualizarCarrinho(carrinho); // Atualiza o carrinho no servidor
  }

  // Método para remover um ingrediente do carrinho
  Future<void> removerIngrediente(Carrinho carrinho, String ingrediente) async {
    carrinho.ingredientes.remove(ingrediente); // Remove o ingrediente
    await atualizarCarrinho(carrinho); // Atualiza o carrinho no servidor
  }
}
