import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';

class AnotacaoReceita {
  final int id;
  String anotacao;
  Usuario usuario;
  Receita receita;

  AnotacaoReceita({
    this.id = 0,
    required this.anotacao,
    required this.usuario,
    required this.receita,
  });

  factory AnotacaoReceita.fromJson(Map<String, dynamic> json) {
    return AnotacaoReceita(
      id: json['id'],
      anotacao: json['anotacao'],
      usuario: Usuario.fromJson(json['usuario']),
      receita: Receita.fromJson(json['receita']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id == 0 ? null : id,
      'anotacao': anotacao,
      'usuario': usuario.toJson(),
      'receita': receita.toSecondaryJson(),
    };
  }
}
