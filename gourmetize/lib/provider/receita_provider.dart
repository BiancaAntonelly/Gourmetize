import 'package:flutter/material.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/service/receita_service.dart';
import 'package:gourmetize/model/usuario.dart';

class ReceitaProvider with ChangeNotifier {
  final ReceitaService _receitaService = ReceitaService();

  List<Receita> _receitas = [];
  List<Receita> _favoritas = [];
  List<Receita> _receitasUser = [];
  List<Receita> get receitas => [..._receitas];
  List<Receita> get favoritas => [..._favoritas];
  List<Receita> get receitasUser => [..._receitasUser];

  Future<void> buscarReceitas(Usuario usuario) async {
    _receitas = await _receitaService.buscarReceitas();
    _favoritas = await _receitaService.buscarReceitasFavoritas(usuario);
    notifyListeners();
  }

  Future<void> adicionarReceita(Receita receita) async {
    await _receitaService.adicionarReceita(receita);
    _receitas.add(receita);
    _receitasUser.add(receita);
    notifyListeners();
  }

  Future<void> removerReceita(Receita receita) async {
    await _receitaService.removerReceita(receita);
    _receitas.removeWhere((item) => item.id == receita.id);
    _receitasUser.removeWhere((item) => item.id == receita.id);
    _favoritas.removeWhere((item) => item.id == receita.id);
    notifyListeners();
  }

  Future<void> atualizarReceita(Receita receita) async {
    await _receitaService.atualizarReceita(receita);
    var index = _receitas.indexWhere((r) => r.id == receita.id);
    _receitas[index] = receita;
    index = _receitasUser.indexWhere((r) => r.id == receita.id);
    if (index != -1) _receitasUser[index] = receita;
    index = _favoritas.indexWhere((r) => r.id == receita.id);
    if (index != -1) _favoritas[index] = receita;
    notifyListeners();
  }

  Future<void> toggleFavorita(Receita receita, Usuario usuario) async {
    if (!isFavorita(receita)) {
      await _receitaService.favoritarReceita(receita, usuario);
      _favoritas.add(receita);
    } else {
      await _receitaService.desfavoritarReceita(receita, usuario);

      _favoritas.removeWhere((item) => item.id == receita.id);
    }
    notifyListeners();
  }

  bool isFavorita(Receita receita) {
    final isFavorite = _favoritas.any((favorita) => favorita.id == receita.id);
    return isFavorite;
  }

  Future<List<Receita>> buscarReceitasPorUsuario(Usuario usuario) async {
    _receitasUser = await _receitaService.buscarReceitasPorUsuario(usuario);
    notifyListeners();
    return _receitasUser; // Retorna a lista de receitas.
  }

  void atualizarNota(Receita receita, double nota) {
    final index = _receitas.indexWhere((e) => e.id == receita.id);

    _receitas[index].mediaAvaliacao = nota;

    notifyListeners();
  }
}
