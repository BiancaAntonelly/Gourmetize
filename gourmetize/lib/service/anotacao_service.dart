import 'dart:convert';

import 'package:gourmetize/config/app_config.dart';
import 'package:gourmetize/model/anotacao_receita.dart';
import 'package:http/http.dart' as http;

class AnotacaoService {
  final String _baseUrl = "${AppConfig.baseUrl}/anotacoes";

  Future<AnotacaoReceita> criarAnotacao(AnotacaoReceita anotacao) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode(anotacao.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao criar anotação");
    }

    return AnotacaoReceita.fromJson(jsonDecode(response.body));
  }

  Future<AnotacaoReceita?> getAnotacao(int usuarioId, int receitaId) async {
    final response = await http.get(
      Uri.parse("$_baseUrl?usuarioId=$usuarioId&receitaId=$receitaId"),
    );
    print(response.body);

    if (response.statusCode != 200) {
      if (response.statusCode == 404) {
        return null;
      }

      throw Exception("Erro ao recuperar anotação");
    }

    return AnotacaoReceita.fromJson(jsonDecode(response.body));
  }

  Future<AnotacaoReceita> atualizarAnotacao(AnotacaoReceita anotacao) async {
    final response = await http.put(
      Uri.parse("$_baseUrl/${anotacao.id}"),
      body: jsonEncode(anotacao.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar anotação");
    }

    return AnotacaoReceita.fromJson(jsonDecode(response.body));
  }

  Future<void> deletarAnotacao(AnotacaoReceita anotacao) async {
    final response = await http.delete(Uri.parse("$_baseUrl/${anotacao.id}"));

    if (response.statusCode != 200) {
      throw Exception("Erro ao deletar anotação");
    }
  }
}
