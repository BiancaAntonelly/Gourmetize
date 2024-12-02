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


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'ingredientes': ingredientes,
      'preparo': preparo,
      'usuario': usuario.toJson(),
      'avaliacoes': avaliacoes.map((avaliacao) => avaliacao.toJson()).toList(),
      'etiquetas': etiquetas.map((etiqueta) => etiqueta.toJson()).toList(),
    };
  }

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      ingredientes: json['ingredientes'],
      preparo: json['preparo'],
      usuario: Usuario.fromJson(json['usuario']),
      avaliacoes: (json['avaliacoes'] as List<dynamic>)
          .map((avaliacao) => Avaliacao.fromJson(avaliacao))
          .toList(),
      etiquetas: (json['etiquetas'] as List<dynamic>)
          .map((etiqueta) => Etiqueta.fromJson(etiqueta))
          .toList(),
    );
  }

}
