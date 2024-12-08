import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';

class Avaliacao {
  int id;
  int nota;
  String comentario;
  Usuario usuario;
  Receita receita;

  Avaliacao({
    this.id = 0,
    required this.nota,
    required this.comentario,
    required this.usuario,
    required this.receita,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id == 0 ? null : id,
      'nota': nota,
      'comentario': comentario,
      'usuario': usuario.toJson(),
      'receita': receita.toJson(),
    };
  }

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      id: json['id'],
      nota: json['nota'],
      comentario: json['comentario'],
      usuario: Usuario.fromJson(json['usuario']),
      receita: Receita.fromJson(json['receita']),
    );
  }
}
