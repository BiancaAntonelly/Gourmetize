import 'dart:math';

import 'package:gourmetize/model/avaliacao.dart';
import 'package:gourmetize/model/etiqueta.dart';

import 'usuario.dart';

class Receita {
  final int id = Random().nextInt(10000);
  String titulo;
  String descricao;
  String ingredientes;
  String preparo;
  Usuario usuario;
  List<Avaliacao> avaliacoes;
  List<Etiqueta> etiquetas;

  Receita({
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
