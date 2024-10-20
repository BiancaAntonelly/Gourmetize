import 'ingrediente.dart';
import 'usuario.dart';

class Receita {

  int id;
  String nome;
  String descricao;
  List<Ingrediente> ingredientes = [];
 
  Receita({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.ingredientes
  });


}