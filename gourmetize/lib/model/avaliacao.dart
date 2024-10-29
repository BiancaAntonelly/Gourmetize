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
}
