import 'enum_unidade.dart';

class Ingrediente {
  String nome;
  String quantidade;
  Unidade unidade;

  Ingrediente({
    required this.nome, 
    required this.quantidade, 
    required this.unidade
  });

}