import 'dart:convert';

import 'package:gourmetize/model/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  final String _baseUrl = 'http://127.0.0.1:8080/usuarios';

  Future<Usuario> createUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Ocorreu um erro ao criar o usuário");
    }

    return Usuario.fromJson(jsonDecode(response.body));
  }

  Future<Usuario> getSelf(String token) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}/me"),
      headers: {'Authorization': 'Bearer ${token}'},
    );

    if (response.statusCode != 201) {
      throw Exception("Ocorreu um erro ao recuperar o usuário");
    }

    return Usuario.fromJson(jsonDecode(response.body));
  }
}
