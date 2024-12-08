import 'package:gourmetize/model/usuario.dart';

class Etiqueta {
  final int id;
  String nome;
  Usuario usuario;

  Etiqueta({this.id = 0, required this.nome, required this.usuario});

  Map<String, dynamic> toJson() {
    return {
      'id': id == 0 ? null : id,
      'nome': nome,
      'usuario': usuario.toJson(),
    };
  }

  factory Etiqueta.fromJson(Map<String, dynamic> json) {
    return Etiqueta(
      id: json['id'],
      nome: json['nome'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }
}
