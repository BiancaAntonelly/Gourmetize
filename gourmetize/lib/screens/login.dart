import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:gourmetize/widgets/logo.dart';

class Login extends StatefulWidget {
  final List<Usuario> usuarios;
  final void Function(Usuario) onLogarUsuario;

  const Login({Key? key, required this.usuarios, required this.onLogarUsuario})
      : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF5E3023),
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height,
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
                        fontSize: screenSize.width * 0.05 * 2.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.1),
                _buildTextFields(),
                SizedBox(height: screenSize.height * 0.05),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        _buildCustomTextField(
          controller: _emailController,
          hintText: 'E-mail',
          icon: Icons.email,
          obscureText: false,
        ),
        SizedBox(height: 20),
        _buildCustomTextField(
          controller: _passwordController,
          hintText: 'Senha',
          icon: Icons.lock,
          obscureText: true,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ' Esqueci minha senha',
            style: TextStyle(
              fontSize: 16,
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
        controller: controller,
        style: const TextStyle(
          color: Color(0xFF5E3023),
          fontSize: 18,
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
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildButton(
          'Entrar',
          () => _login(context),
        ),
        const SizedBox(height: 10),
        _buildButton(
          'Realizar cadastro',
          () => _navigateToSignup(context),
        ),
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
          padding: const EdgeInsets.symmetric(vertical: 15),
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

  void _login(BuildContext context) {
    final email = _emailController.text;
    final senha = _passwordController.text;

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira o e-mail e a senha')),
      );
      return;
    }

    final usuario = widget.usuarios.firstWhere(
      (usuario) => usuario.email == email && usuario.senha == senha,
      orElse: () => Usuario(id: -1, nome: '', email: '', senha: ''),
    );

    if (usuario.id == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail ou senha incorretos')),
      );
    } else {
      widget.onLogarUsuario(usuario);

      context.go('/');
    }
  }

  void _navigateToSignup(BuildContext context) {
    context.go('/register');
  }
}
