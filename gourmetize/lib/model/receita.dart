import 'package:gourmetize/model/etiqueta.dart';

import 'usuario.dart';

class Receita {
  final int id;
  String titulo;
  String descricao;
  String ingredientes;
  String preparo;
  Usuario usuario;
  double? mediaAvaliacao;
  List<Etiqueta> etiquetas;

  Receita({
    this.id = 0,
    required this.titulo,
    required this.descricao,
    required this.ingredientes,
    required this.preparo,
    this.mediaAvaliacao,
    required this.usuario,
    List<Etiqueta>? etiquetas,
  }) : etiquetas = etiquetas ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id == 0 ? null : id,
      'titulo': titulo,
      'descricao': descricao,
      'ingredientes': ingredientes,
      'preparo': preparo,
      'usuario': usuario.toJson(),
      'etiquetas': etiquetas.map((etiqueta) => etiqueta.toJson()).toList(),
    };
  }

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      ingredientes: json['ingredientes'] ?? '',
      preparo: json['preparo'] ?? '',
      usuario: Usuario.fromJson(json['usuario']),
      mediaAvaliacao: json['mediaAvaliacao'],
      etiquetas: (json['etiquetas'] as List<dynamic>?)
              ?.map((etiqueta) => Etiqueta.fromJson(etiqueta))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'Receita{id: $id, titulo: $titulo, descricao: $descricao, ingredientes: $ingredientes, preparo: $preparo, usuario: ${usuario.nome}, etiquetas: $etiquetas}';
  }
}
