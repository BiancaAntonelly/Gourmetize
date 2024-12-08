import 'package:flutter/material.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/service/avaliacao_service.dart';

import 'package:flutter/material.dart';

class AvaliacaoProvider with ChangeNotifier {
  List<Avaliacao> _avaliacoes = [];
  final AvaliacaoService _avaliacoesService = AvaliacaoService();

  // Getter para as avaliações de receitas
  List<Avaliacao> get avaliacoes => [..._avaliacoes];

  // Criar uma avaliação para uma receita
  Future<Avaliacao> createAvaliacaoParaReceita(Avaliacao avaliacao) async {
    try {
      final created =
          await _avaliacoesService.criarAvaliacaoParaReceita(avaliacao);
      _avaliacoes.add(created);
      notifyListeners(); // Notifica os listeners sobre a atualização
      return created;
    } catch (e) {
      throw Exception("Erro ao criar avaliação para receita: $e");
    }
  }

  // Buscar avaliações por ID da receita
  Future<List<Avaliacao>> getAvaliacoesPorReceita(int receitaId) async {
    try {
      _avaliacoes = await _avaliacoesService.getAvaliacoesPorReceita(receitaId);
      notifyListeners(); // Atualiza o estado
      return _avaliacoes;
    } catch (e) {
      throw Exception("Erro ao buscar avaliações para receita: $e");
    }
  }
}
