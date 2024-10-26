import 'package:gourmetize/model/receita.dart';

class Usuario {
  int id;
  String nome;
  String email;
  String senha;
  List<Receita> receitas;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    this.receitas = const [], // Inicializa como lista vazia se não fornecida
  });
}
