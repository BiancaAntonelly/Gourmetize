import 'dart:convert';

import 'package:gourmetize/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:gourmetize/config/app_config.dart';

class AuthService {
  final String _baseUrl =  AppConfig.baseUrl + '/auth';

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
