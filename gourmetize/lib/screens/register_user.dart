import 'package:flutter/material.dart';
import '../model/usuario.dart';
import '../widgets/logo.dart';
import 'package:go_router/go_router.dart';

class RegisterUser extends StatelessWidget {
  final List<Usuario> usuarios; // Lista de usuários
  final void Function(Usuario) onAddUsuario;

  RegisterUser({Key? key, required this.usuarios, required this.onAddUsuario})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF5E3023),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenSize.height),
          child: IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/background.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1,
                  vertical: screenSize.height * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        LogoWidget(
                          size: screenSize.height * 0.11,
                          iconColor: Colors.orange,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Text(
                          'Gourmetize',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.05 * 2.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.08),
                    _buildTextFields(
                        _nomeController, 'Nome', false, false, screenSize),
                    SizedBox(height: screenSize.height * 0.01),
                    _buildTextFields(
                        _emailController, 'E-mail', true, false, screenSize),
                    SizedBox(height: screenSize.height * 0.01),
                    _buildTextFields(
                        _senhaController, 'Senha', false, true, screenSize),
                    SizedBox(height: screenSize.height * 0.01),
                    _buildTextFields(_senhaConfirmController,
                        'Confirme sua senha', false, true, screenSize),
                    SizedBox(height: screenSize.height * 0.05),
                    _buildRegisterButton(context, screenSize),
                    SizedBox(height: screenSize.height * 0.02),
                    _buildLoginLink(context, screenSize),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields(TextEditingController controller, String hintText,
      bool isEmail, bool isPassword, Size screenSize) {
    return Container(
      height: screenSize.height * 0.06,
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
        controller: controller,
        style: TextStyle(
          color: const Color(0xFF5E3023),
          fontSize: screenSize.width * 0.04,
        ),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            isEmail
                ? Icons.email
                : isPassword
                    ? Icons.lock
                    : Icons.person,
            color: Colors.orange,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xFF5E3023),
            fontSize: screenSize.width * 0.04,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, Size screenSize) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String email = _emailController.text.trim();
          String nome = _nomeController.text.trim();
          String senha = _senhaController.text.trim();
          String senhaConfirm = _senhaConfirmController.text.trim();

          // Verifica se as senhas batem
          if (senha != senhaConfirm) {
            _showMessage(context, 'As senhas não coincidem.');
            return;
          }

          if (usuarios.any((usuario) => usuario.email == email)) {
            _showMessage(context, 'Este e-mail já está em uso.');
            return;
          }

          onAddUsuario(Usuario.semId(nome: nome, email: email, senha: senha));
          _limparCampos();
          _showMessage(context, 'Usuário registrado com sucesso!');

          context.go('/login');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Registrar-se',
          style: TextStyle(
            fontSize: screenSize.width * 0.05,
            color: const Color(0xFF5E3023),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context, Size screenSize) {
    return Column(
      children: [
        Text(
          'Já tem uma conta?',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenSize.width * 0.04,
          ),
        ),
        TextButton(
          onPressed: () {
            context.go('/login');
          },
          child: Text(
            'Faça login',
            style: TextStyle(
              color: Colors.orange,
              fontSize: screenSize.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
