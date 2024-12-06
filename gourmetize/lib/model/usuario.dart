import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/receita.dart';

class Usuario {
  int id;
  String nome;
  String email;
  String senha;
  List<Receita> receitas;
  List<Etiqueta> etiquetas;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    List<Receita>? receitas,
    List<Etiqueta>? etiquetas,
  })  : receitas = receitas ?? [],
        etiquetas = etiquetas ?? [];

  Usuario.semId({
    required this.nome,
    required this.email,
    required this.senha,
    List<Receita>? receitas,
    List<Etiqueta>? etiquetas,
  })  : id = 0, // ou outro valor padrão, se desejar
        receitas = receitas ?? [],
        etiquetas = etiquetas ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id == 0 ? null : id,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      receitas: json['receitas'] != null
          ? (json['receitas'] as List<dynamic>)
              .map((receita) => Receita.fromJson(receita))
              .toList()
          : [],
      etiquetas: json['etiquetas'] != null
          ? (json['etiquetas'] as List<dynamic>)
              .map((etiqueta) => Etiqueta.fromJson(etiqueta))
              .toList()
          : [],
    );
  }
}
