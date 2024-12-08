import 'package:flutter/material.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/service/auth_service.dart';
import 'package:gourmetize/service/usuario_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final UsuarioService _usuarioService = UsuarioService();

  Usuario? _usuarioLogado;

  Usuario? get usuarioLogado => _usuarioLogado;

  Future<Usuario> login(String email, String password) async {
    _usuarioLogado = await _authService.login(email, password);

    notifyListeners();

    return _usuarioLogado!;
  }

  Future<Usuario> register(Usuario usuario) async {
    return _usuarioService.createUsuario(usuario);
  }

  void logout() {
    _usuarioLogado = null;

    notifyListeners();
  }
}
