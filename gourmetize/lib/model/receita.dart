import 'dart:math';

import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/etiqueta.dart';

import 'usuario.dart';

class Receita {
  final int id;
  String titulo;
  String descricao;
  String ingredientes;
  String preparo;
  Usuario usuario;
  List<Avaliacao> avaliacoes;
  List<Etiqueta> etiquetas;

  Receita({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.ingredientes,
    required this.preparo,
    required this.usuario,
    List<Avaliacao>? avaliacoes,
    List<Etiqueta>? etiquetas,
  })  : avaliacoes = avaliacoes ?? [],
        etiquetas = etiquetas ?? [];
}
