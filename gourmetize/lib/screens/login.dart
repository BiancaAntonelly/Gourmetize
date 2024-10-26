import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/logo.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF5E3023),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // Ajuste a opacidade aqui
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
                  LogoWidget(size: screenSize.height * 0.11),
                  const SizedBox(height: 5),
                  const Text(
                    'COOKING',
                    style: TextStyle(
                      fontSize: 72.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 150),
              _buildTextFields(_emailController, _passwordController),
              const SizedBox(height: 40),
              _buildButtons(context, _emailController, _passwordController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields(TextEditingController emailController,
      TextEditingController passwordController) {
    return Column(
      children: [
        _buildCustomTextField(
          controller: emailController,
          hintText: 'E-mail',
          icon: Icons.email,
          obscureText: false,
        ),
        const SizedBox(height: 20),
        _buildCustomTextField(
          controller: passwordController,
          hintText: 'Senha',
          icon: Icons.lock,
          obscureText: true,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Esqueci minha senha',
            style: TextStyle(
              fontSize: 18.0,
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
  }) {
    return Container(
      height: 60,
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
        style: const TextStyle(
          color: Color(0xFF5E3023),
          fontSize: 15.0,
        ),
        keyboardType: obscureText
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.orange),
          hintText: hintText,
          filled: false,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
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
      TextEditingController passwordController) {
    return Column(
      children: [
        _buildButton('Entrar',
            () => _login(context, emailController, passwordController)),
        const SizedBox(height: 12),
        _buildButton('Realizar cadastro', () => _navigateToSignup(context)),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF5E3023),
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
    } else {
      print('Tentando fazer login com email: $email e senha: $senha');
    }
  }

  void _navigateToSignup(BuildContext context) {
    context.go('/register');
  }
}
