import 'dart:math';

import 'package:gourmetize/model/usuario.dart';

class Etiqueta {
  final int id = Random().nextInt(10000);
  String nome;
  Usuario usuario;

  Etiqueta({required this.nome, required this.usuario});
}
