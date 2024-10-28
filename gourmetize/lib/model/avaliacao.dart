import 'package:gourmetize/model/usuario.dart';

class Avaliacao {
  int id;
  int nota;
  String comentario;
  Usuario usuario;

  Avaliacao(
      {required this.id,
      required this.nota,
      required this.comentario,
      required this.usuario});
}
