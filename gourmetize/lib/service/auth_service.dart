import 'dart:convert';

import 'package:gourmetize/model/usuario.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:8080/auth';

  Future<Usuario> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception("Credenciais inválidas");
    }

    return Usuario.fromJson(jsonDecode(response.body));
  }
}
