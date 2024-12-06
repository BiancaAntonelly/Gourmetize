import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';

class ReceitaService {
  final String baseUrl = 'http://10.0.2.2:8080/receitas';

  Future<List<Receita>> buscarReceitasFavoritas(Usuario usuario) async {
    try {
      final url = Uri.parse('$baseUrl/receitas/favoritas/${usuario.id}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Receita.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        print("Usuário não encontrado.");
        return [];
      } else {
        print("Erro ao buscar receitas favoritas: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar receitas favoritas: $e");
      return [];
    }
  }

  Future<void> adicionarReceita(Receita receita) async {
    try {
      final url = Uri.parse('$baseUrl');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(receita.toJson()),
      );
      print("Receita a ser adicionada: $receita");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Receita adicionada com sucesso.");
      } else {
        print("Erro ao adicionar receita: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao adicionar receita: $e");
    }
  }

  Future<void> removerReceita(Receita receita) async {
    try {
      final url = Uri.parse('$baseUrl/receitas/${receita.id}');
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        print("Receita removida com sucesso.");
      } else if (response.statusCode == 404) {
        print("Receita não encontrada.");
      } else {
        print("Erro ao remover receita: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao remover receita: $e");
    }
  }

  Future<void> atualizarReceita(Receita receita) async {
    try {
      final url = Uri.parse('$baseUrl/receitas/${receita.id}');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(receita.toJson()),
      );

      if (response.statusCode == 200) {
        print("Receita atualizada com sucesso.");
      } else if (response.statusCode == 404) {
        print("Receita não encontrada.");
      } else {
        print("Erro ao atualizar receita: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao atualizar receita: $e");
    }
  }

  Future<void> favoritarReceita(Receita receita, Usuario usuario) async {
    try {
      final url = Uri.parse('$baseUrl/receitas/favoritas/${usuario.id}/${receita.id}');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        print("Receita favoritada com sucesso.");
      } else if (response.statusCode == 404) {
        print("Usuário ou receita não encontrado.");
      } else {
        print("Erro ao favoritar a receita: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao favoritar a receita: $e");
    }
  }

  Future<void> desfavoritarReceita(Receita receita, Usuario usuario) async {
    try {
      final url = Uri.parse('$baseUrl/receitas/favoritas/${usuario.id}/${receita.id}');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print("Receita desfavoritada com sucesso.");
      } else if (response.statusCode == 404) {
        print("Usuário ou receita não encontrado.");
      } else {
        print("Erro ao desfavoritar a receita: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao desfavoritar a receita: $e");
    }
  }
  Future<List<Receita>> buscarReceitas() async {
    final response = await http.get(Uri.parse('https://api.exemplo.com/receitas'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Receita.fromJson(e)).toList();
    } else {
      throw Exception('Falha ao carregar receitas');
    }
  }
}
