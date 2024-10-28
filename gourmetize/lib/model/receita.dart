import 'package:gourmetize/model/avaliacao.dart';

import 'usuario.dart';

class Receita {
  int id;
  String titulo;
  String descricao;
  String ingredientes;
  List<Avaliacao> avaliacoes;
  String preparo;

  Receita({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.ingredientes,
    required this.preparo,
    this.avaliacoes = const [],
  });
}
