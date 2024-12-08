import 'dart:convert';

import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:gourmetize/config/app_config.dart';

class UsuarioService {
  final String _baseUrl = AppConfig.baseUrl + '/usuario';

  Future<Usuario> createUsuario(Usuario usuario) async {
    print(usuario.toJson());
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode(usuario.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception("Ocorreu um erro ao criar o usuário");
    }

    return Usuario.fromJson(jsonDecode(response.body));
  }

  Future<List<Etiqueta>> getEtiquetas(int usuarioId) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/$usuarioId/etiquetas"),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao recuperar etiquetas");
    }

    final List<dynamic> list = jsonDecode(response.body);

    return list.map((e) => Etiqueta.fromJson(e)).toList();
  }
}
