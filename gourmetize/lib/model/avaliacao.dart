import 'dart:math';

import 'package:gourmetize/model/usuario.dart';

class Avaliacao {
  final int id = Random().nextInt(10000);
  int nota;
  String comentario;
  Usuario usuario;

  Avaliacao({
    required this.nota,
    required this.comentario,
    required this.usuario,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nota': nota,
      'comentario': comentario,
      'usuario': usuario.toJson(),
    };
  }

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      nota: json['nota'],
      comentario: json['comentario'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }
}
