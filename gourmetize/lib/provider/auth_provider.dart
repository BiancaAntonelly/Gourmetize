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
    _token = await _authService.auth(email, password);

    _usuarioLogado = await _usuarioService.getSelf(_token!);

    notifyListeners();

    return _usuarioLogado!;
  }

  Future<Usuario> register(Usuario usuario) async {
    _usuarioLogado = await _usuarioService.createUsuario(usuario);

    notifyListeners();

    return _usuarioLogado!;
  }
}
