import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/service/receita_service.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/model/avaliacao.dart';

class ReceitaProvider with ChangeNotifier {
  final ReceitaService _receitaService = ReceitaService();

  List<Receita> _receitas = [];
  List<Receita> _favoritas = [];
  List<Receita> get receitas => [..._receitas];
  List<Receita> get favoritas => [..._favoritas];

  Future<void> buscarReceitas() async {
    _receitas = await _receitaService.buscarReceitas();
    notifyListeners();
  }

  Future<void> adicionarReceita(Receita receita) async {
    await _receitaService.adicionarReceita(receita);
    _receitas.add(receita);
    notifyListeners();
  }

  Future<void> removerReceita(Receita receita) async {
    await _receitaService.removerReceita(receita);
    _receitas.remove(receita);
    notifyListeners();
  }

  Future<void> atualizarReceita(Receita receita) async {
    await _receitaService.atualizarReceita(receita);
    final index = _receitas.indexWhere((r) => r.id == receita.id);
    _receitas[index] = receita;
    notifyListeners();
  }

  Future<void> toggleFavorita(Receita receita, Usuario usuario) async {
    if (_favoritas.contains(receita)) {
      await _receitaService.favoritarReceita(receita, usuario);
      _favoritas.remove(receita);
    } else {
      await _receitaService.desfavoritarReceita(receita, usuario);
      _favoritas.add(receita);
    }
    notifyListeners();
  }

  bool isFavorita(Receita receita) {
    return _favoritas.contains(receita);
  }

}
