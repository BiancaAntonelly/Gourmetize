import 'package:flutter/material.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/service/auth_service.dart';
import 'package:gourmetize/service/usuario_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final UsuarioService _usuarioService = UsuarioService();

  String? _token;
  Usuario? _usuarioLogado;

  String? get token => _token;
  Usuario? get usuarioLogado => _usuarioLogado;

  Future<Usuario> login(String email, String password) async {

    _usuarioLogado= Usuario(
      id: 1,
      nome: "Mock User",
      email: "m",
      senha: "m",
      receitas: [],
      etiquetas: [],
    );
    _token = 'mocked_token_123';

    notifyListeners();
    return _usuarioLogado!;
  }


  Future<Usuario> register(Usuario usuario) async {
    _usuarioLogado = await _usuarioService.createUsuario(usuario);

    notifyListeners();

    return _usuarioLogado!;
  }
}
