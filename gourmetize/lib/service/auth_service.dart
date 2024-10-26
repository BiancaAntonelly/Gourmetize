import 'dart:math';
import 'package:gourmetize/model/usuario.dart';

class AuthService {
  // A instância singleton
  static final AuthService _instance = AuthService._internal();

  // Construtor interno
  AuthService._internal();

  // Fábrica que retorna a instância singleton
  factory AuthService() {
    return _instance;
  }

  final List<Usuario> _usuariosCadastrados = [];

  void registrarUsuario(Usuario usuario) {
    _usuariosCadastrados.add(usuario);
  }

  bool verificarCredenciais(String email, String senha) {
    for (var usuario in _usuariosCadastrados) {
      if (usuario.email == email && usuario.senha == senha) {
        return true;
      }
    }
    return false;
  }

  bool checarSenhas(String senha, String senhaConfirm) {
    return senha == senhaConfirm;
  }

  List<Usuario> listarUsuarios() {
    return List.unmodifiable(_usuariosCadastrados);
  }
}
