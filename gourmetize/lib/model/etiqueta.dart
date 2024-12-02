import 'dart:math';

import 'package:gourmetize/model/usuario.dart';

class Etiqueta {
  final int id = Random().nextInt(10000);
  String nome;
  Usuario usuario;

  Etiqueta({required this.nome, required this.usuario});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'usuario': usuario.toJson(),
    };
  }

  factory Etiqueta.fromJson(Map<String, dynamic> json) {
    return Etiqueta(
      nome: json['nome'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }
}
