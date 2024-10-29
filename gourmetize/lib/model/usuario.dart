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
}
