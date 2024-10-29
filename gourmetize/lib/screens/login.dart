import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/model/receita.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/widgets/logo.dart';

class Login extends StatelessWidget {
  final List<Usuario> usuarios; // Lista de usuários cadastrados

  const Login({Key? key, required this.usuarios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final screenSize = MediaQuery.of(context).size;

    // Definindo proporções para fontes e espaçamentos
    final double baseFontSize = screenSize.width * 0.05;
    final double logoSize = screenSize.height * 0.11;
    final double buttonFontSize = screenSize.width * 0.045;
    final double inputHeight = screenSize.height * 0.07;

    return Scaffold(
      backgroundColor: const Color(0xFF5E3023),
      body: SingleChildScrollView(
        // Permite rolagem
        child: Container(
          height: screenSize.height, // Mantém o tamanho da tela
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/background.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
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
                        fontSize: baseFontSize * 2.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.1),
                _buildTextFields(
                    _emailController, _passwordController, inputHeight),
                SizedBox(height: screenSize.height * 0.05),
                _buildButtons(context, _emailController, _passwordController,
                    buttonFontSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields(TextEditingController emailController,
      TextEditingController passwordController, double inputHeight) {
    return Column(
      children: [
        _buildCustomTextField(
          controller: emailController,
          hintText: 'E-mail',
          icon: Icons.email,
          obscureText: false,
          height: inputHeight,
        ),
        SizedBox(height: inputHeight * 0.2),
        _buildCustomTextField(
          controller: passwordController,
          hintText: 'Senha',
          icon: Icons.lock,
          obscureText: true,
          height: inputHeight,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ' Esqueci minha senha',
            style: TextStyle(
              fontSize: inputHeight * 0.28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool obscureText,
    required double height,
  }) {
    return Container(
      height: height,
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
          fontSize: height * 0.3,
        ),
        keyboardType: obscureText
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.orange, size: height * 0.3),
          hintText: hintText,
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: height * 0.3, horizontal: height * 0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      double buttonFontSize) {
    return Column(
      children: [
        _buildButton(
          'Entrar',
          () => _login(context, emailController, passwordController),
          buttonFontSize,
        ),
        SizedBox(height: buttonFontSize * 0.2),
        _buildButton(
          'Realizar cadastro',
          () => _navigateToSignup(context),
          buttonFontSize,
        ),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, double fontSize) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(vertical: fontSize * 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF5E3023),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController) {
    final email = emailController.text;
    final senha = passwordController.text;

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira o e-mail e a senha')),
      );
      return;
    }

    // Verifica se o usuário existe na lista de usuários
    final usuario = usuarios.firstWhere(
      (usuario) => usuario.email == email && usuario.senha == senha,
      orElse: () => Usuario(id: -1, nome: '', email: '', senha: ''),
    );

    if (usuario.id == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail ou senha incorretos')),
      );
    } else {
      print('Login bem-sucedido com e-mail: $email');
      // Navegar para a próxima tela ou fazer outras ações
    }
  }

  void _navigateToSignup(BuildContext context) {
    context.go('/register');
  }
}
