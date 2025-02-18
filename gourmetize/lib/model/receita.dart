import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/ingrediente.dart';

import 'usuario.dart';

class Receita {
  final int id;
  String titulo;
  String descricao;
  List<Ingrediente> ingredientes; // Lista de objetos Ingrediente
  String preparo;
  Usuario usuario;
  double? mediaAvaliacao;
  String imageUrl;
  String? youtubeId;
  List<Etiqueta> etiquetas;

  Receita({
    this.id = 0,
    required this.titulo,
    required this.descricao,
    required this.ingredientes,
    required this.preparo,
    this.mediaAvaliacao,
    required this.usuario,
    required this.imageUrl,
    this.youtubeId,
    List<Etiqueta>? etiquetas,
  }) : etiquetas = etiquetas ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id == 0 ? null : id,
      'titulo': titulo,
      'descricao': descricao,
      'ingredientes': ingredientes
          .map((ingrediente) => ingrediente.toJson())
          .toList(), // Convertendo a lista de ingredientes
      'preparo': preparo,
      'usuario': usuario.toJson(),
      'youtubeId': youtubeId,
      'imageUrl': imageUrl,
      'etiquetas': etiquetas.map((etiqueta) => etiqueta.toJson()).toList(),
    };
  }

  Map<String, dynamic> toSecondaryJson() {
    return {
      'id': id == 0 ? null : id,
      'titulo': titulo,
      'descricao': descricao,
      'ingredientes': ingredientes
          .map((ingrediente) => ingrediente.toSecondaryJson())
          .toList(), // Convertendo a lista de ingredientes
      'preparo': preparo,
      'usuario': usuario.toJson(),
      'youtubeId': youtubeId,
      'imageUrl': imageUrl,
      'etiquetas': etiquetas.map((etiqueta) => etiqueta.toJson()).toList(),
    };
  }

  factory Receita.fromJson(Map<String, dynamic> json) {
    return Receita(
      id: json['id'],
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      ingredientes: (json['ingredientes'] as List<dynamic>?)
              ?.map((ingredienteJson) => Ingrediente.fromJson(ingredienteJson))
              .toList() ??
          [],
      preparo: json['preparo'] ?? '',
      usuario: Usuario.fromJson(json['usuario']),
      mediaAvaliacao: json['mediaAvaliacao'],
      imageUrl: json['imageUrl'] ?? '',
      youtubeId: json['youtubeId'] ?? '',
      etiquetas: (json['etiquetas'] as List<dynamic>?)
              ?.map((etiqueta) => Etiqueta.fromJson(etiqueta))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'Receita{id: $id, titulo: $titulo, descricao: $descricao, ingredientes: $ingredientes, preparo: $preparo, usuario: ${usuario.nome}, imageUrl: $imageUrl, youtubeId: $youtubeId, etiquetas: $etiquetas}';
  }
}
