
import 'package:gourmetize/model/usuario.dart';

class Avaliacao {
  int id;
  int nota;
  String comentario;
  Usuario usuario;

  Avaliacao({
    this.id = 0,
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
