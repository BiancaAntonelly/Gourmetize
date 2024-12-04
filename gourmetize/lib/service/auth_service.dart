import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://127.0.0.1:8080/auth';

  Future<String> auth(String email, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw Exception("Credenciais inválidas");
    }

    return jsonDecode(response.body)['token'];
  }
}
