import 'package:gourmetize/model/avaliacao.dart';

import 'usuario.dart';

class Receita {
  int id;
  String nome;
  String descricao;
  String ingredientes;
  List<Avaliacao> avaliacoes;

  Receita({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.ingredientes,
    this.avaliacoes = const [],
  });
}
