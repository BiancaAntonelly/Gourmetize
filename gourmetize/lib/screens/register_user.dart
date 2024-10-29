import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gourmetize/service/auth_service.dart';
import '../model/usuario.dart';
import '../widgets/logo.dart';
import 'package:go_router/go_router.dart';

class RegisterUser extends StatelessWidget {
  RegisterUser({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _senhaConfirmController = TextEditingController();

  void _limparCampos() {
    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    _senhaConfirmController.clear();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  int _generateRandomId() {
    return Random().nextInt(1000000);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF5E3023),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            LogoWidget(
              size: screenSize.height * 0.11,
              iconColor: Colors.orange,
            ),

            const SizedBox(height: 150),
            _buildTextFields(_nomeController, 'Nome', false, false),
            const SizedBox(height: 10),
            _buildTextFields(_emailController, 'E-mail', true, false),
            const SizedBox(height: 10),
            _buildTextFields(_senhaController, 'Senha', false, true),
            const SizedBox(height: 10),
            _buildTextFields(
                _senhaConfirmController, 'Confirme sua senha', false, true),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_authService.checarSenhas(
                      _senhaController.text, _senhaConfirmController.text)) {
                    final novoUsuario = Usuario(
                      id: _generateRandomId(),
                      nome: _nomeController.text,
                      email: _emailController.text,
                      senha: _senhaController.text,
                    );

                    _authService.registrarUsuario(novoUsuario);
                    _limparCampos();
                  } else {
                    _showMessage(context, 'As senhas não coincidem');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: const Color(0xFF5E3023),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Registrar', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20), // Espaço entre o botão e o texto
            const Text(
              'Já tem uma conta?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text(
                'Faça login',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields(TextEditingController textEditingController,
      String text, bool email, bool senha) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Color(0xFF5E3023), fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
        obscureText: senha,
      ),
    );
  }
}
