import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gourmetize/config/app_config.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AvaliacaoService {
  final String baseUrl = AppConfig.baseUrl + '/avaliacoes';

// Criar uma avaliação para uma receita
  Future<Avaliacao> criarAvaliacaoParaReceita(Avaliacao avaliacao) async {
    try {
      final url = Uri.parse('$baseUrl');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(avaliacao.toJson()),
      );

      if (response.statusCode == 200) {
        final String utf8Body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> json = jsonDecode(utf8Body);
        return Avaliacao.fromJson(json); // Retorna o objeto Avaliacao criado
      } else {
        throw Exception(
            "Erro ao criar avaliação para receita: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erro ao criar avaliação para receita: $e");
    }
  }

  // Buscar todas as avaliações
  Future<List<Avaliacao>> buscarTodasAvaliacoes() async {
    try {
      final url = Uri.parse('$baseUrl/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final String utf8Body = utf8.decode(response.bodyBytes);
        final List<dynamic> data = jsonDecode(utf8Body);
        return data.map((json) => Avaliacao.fromJson(json)).toList();
      } else {
        print("Erro ao buscar avaliações: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar avaliações: $e");
      return [];
    }
  }

  // Buscar todas as avaliações de uma receita
  Future<List<Avaliacao>> getAvaliacoesPorReceita(int receitaId) async {
    try {
      final url = Uri.parse('$baseUrl/$receitaId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final String utf8Body = utf8.decode(response.bodyBytes);
        final List<dynamic> data = jsonDecode(utf8Body);
        return data.map((json) => Avaliacao.fromJson(json)).toList();
      } else {
        print("Erro ao buscar avaliações por receita: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar avaliações por receita: $e");
      return [];
    }
  }

  // Buscar uma avaliação pelo ID
  Future<Avaliacao?> buscarAvaliacaoPorId(int id) async {
    try {
      final url = Uri.parse('$baseUrl/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final String utf8Body = utf8.decode(response.bodyBytes);
        final data = jsonDecode(utf8Body);
        return Avaliacao.fromJson(data);
      } else if (response.statusCode == 404) {
        print("Avaliação não encontrada.");
        return null;
      } else {
        print("Erro ao buscar avaliação: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Erro ao buscar avaliação: $e");
      return null;
    }
  }

  // Atualizar uma avaliação
  Future<void> atualizarAvaliacao(Avaliacao avaliacao) async {
    try {
      final url = Uri.parse('$baseUrl/${avaliacao.id}');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(avaliacao.toJson()),
      );

      if (response.statusCode == 200) {
        print("Avaliação atualizada com sucesso.");
      } else if (response.statusCode == 404) {
        print("Avaliação não encontrada.");
      } else {
        print("Erro ao atualizar avaliação: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao atualizar avaliação: $e");
    }
  }

  // Deletar uma avaliação
  Future<void> deletarAvaliacao(int id) async {
    try {
      final url = Uri.parse('$baseUrl/$id');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print("Avaliação deletada com sucesso.");
      } else if (response.statusCode == 404) {
        print("Avaliação não encontrada.");
      } else {
        print("Erro ao deletar avaliação: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao deletar avaliação: $e");
    }
  }
}
