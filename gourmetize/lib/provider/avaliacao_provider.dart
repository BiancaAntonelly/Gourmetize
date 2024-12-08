import 'package:flutter/material.dart';
import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/service/avaliacao_service.dart';

class AvaliacaoProvider with ChangeNotifier {
  List<Avaliacao> _avaliacoes = [];
  final AvaliacaoService _avaliacoesService = AvaliacaoService();

  List<Avaliacao> get avaliacoes => [..._avaliacoes];

  Future<Avaliacao> createAvaliacao(Avaliacao avaliacao) async {
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

  Future<Avaliacao> updateAvaliacao(Avaliacao avaliacao) async {
    try {
      final updated = await _avaliacoesService.atualizarAvaliacao(avaliacao);

      final index = avaliacoes.indexWhere((e) => e.id == avaliacao.id);

      _avaliacoes[index] = updated;

      notifyListeners();

      return updated;
    } catch (e) {
      throw Exception("Erro ao criar avaliação para receita: $e");
    }
  }

  Future<List<Avaliacao>> getAvaliacoes(int receitaId) async {
    try {
      _avaliacoes = await _avaliacoesService.getAvaliacoesPorReceita(receitaId);
      notifyListeners(); // Atualiza o estado
      return _avaliacoes;
    } catch (e) {
      throw Exception("Erro ao buscar avaliações para receita: $e");
    }
  }
}
