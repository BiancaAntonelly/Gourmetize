import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/receita.dart';

class Usuario {
  int id;
  String nome;
  String email;
  String senha;
  List<Receita> receitas;
  List<Etiqueta> etiquetas;

  // Construtor padrão que exige o id
  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    List<Receita>? receitas,
    List<Etiqueta>? etiquetas,
  })  : receitas = receitas ?? [],
        etiquetas = etiquetas ?? [];

  // Construtor nomeado sem o ID
  Usuario.semId({
    required this.nome,
    required this.email,
    required this.senha,
    List<Receita>? receitas,
    List<Etiqueta>? etiquetas,
  })  : id = 0, // ou outro valor padrão, se desejar
        receitas = receitas ?? [],
        etiquetas = etiquetas ?? [];
}
