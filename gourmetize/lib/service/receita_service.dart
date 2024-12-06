import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/config/app_config.dart';

class ReceitaService {
  final String baseUrl = AppConfig.baseUrl + '/receitas';

  Future<List<Receita>> buscarReceitas() async {
    print("buscarReceitas no service");
    print('$baseUrl');

    try {
      final url = Uri.parse('$baseUrl');
      final response = await http.get(url);

      print("Response status: ${response.statusCode}");
      print("Response body (raw): ${response.body}");

      if (response.statusCode == 200) {

        final String utf8Body = utf8.decode(response.bodyBytes);
        final List<dynamic> data = jsonDecode(utf8Body);
        return data.map((json) => Receita.fromJson(json)).toList();

      } else if (response.statusCode == 404) {
        print("Nenhuma receita encontrada.");
        return [];
      } else {
        print("Erro ao buscar receitas: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar receitas: $e");
      return [];
    }
  }

  Future<List<Receita>> buscarReceitasFavoritas(Usuario usuario) async {

    print("buscarReceitasFavoritas no service");
    print('$baseUrl/favoritas/${usuario.id}');

    try {
      final url = Uri.parse('$baseUrl/favoritas/${usuario.id}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final String utf8Body = utf8.decode(response.bodyBytes);
        final List<dynamic> data = jsonDecode(utf8Body);
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
      final url = Uri.parse('$baseUrl/${receita.id}');
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
      final url = Uri.parse('$baseUrl/${receita.id}');
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

    print("favoritar receita");
    print(receita.titulo);
    print(usuario.nome);

    print("Usuario: ${usuario.id}");
    print("Receita: ${receita.id}");
  
    print("$baseUrl/favoritas/${usuario.id}/${receita.id}");

    try {
      final url = Uri.parse('$baseUrl/favoritas/${usuario.id}/${receita.id}');
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

    print("desfavoritar receita");
    print(receita.titulo);
    print(usuario.nome);
    print("Usuario: ${usuario.id}");
    print("Receita: ${receita.id}");

    print("$baseUrl/favoritas/${usuario.id}/${receita.id}");

    try {
      final url = Uri.parse('$baseUrl/favoritas/${usuario.id}/${receita.id}');
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
}
