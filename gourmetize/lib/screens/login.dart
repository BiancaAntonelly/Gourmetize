import 'package:flutter/material.dart';
import 'package:gourmetize/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/logo.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final baseFontSize = screenSize.width * 0.045;

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
                        fontSize: baseFontSize * 3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.1),
                _buildTextFields(baseFontSize),
                SizedBox(height: screenSize.height * 0.05),
                _buildButtons(context, baseFontSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields(double baseFontSize) {
    return Column(
      children: [
        _buildCustomTextField(
          controller: _emailController,
          hintText: 'E-mail',
          icon: Icons.email,
          obscureText: false,
          baseFontSize: baseFontSize,
        ),
        SizedBox(height: baseFontSize * 0.8),
        _buildCustomTextField(
          controller: _passwordController,
          hintText: 'Senha',
          icon: Icons.lock,
          obscureText: true,
          baseFontSize: baseFontSize,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ' Esqueci minha senha',
            style: TextStyle(
              fontSize: baseFontSize * 0.9,
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
    required double baseFontSize,
  }) {
    return Container(
      height: baseFontSize * 3.2,
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
          fontSize: baseFontSize,
        ),
        keyboardType: obscureText
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          prefixIcon:
              Icon(icon, color: Colors.orange, size: baseFontSize * 1.4),
          hintText: hintText,
          filled: false,
          contentPadding: EdgeInsets.symmetric(
              vertical: baseFontSize * 0.8, horizontal: baseFontSize * 0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, double baseFontSize) {
    return Column(
      children: [
        _buildButton(
          'Entrar',
          () => _login(context),
          baseFontSize,
        ),
        SizedBox(height: baseFontSize * 0.4),
        _buildButton(
          'Realizar cadastro',
          () => _navigateToSignup(context),
          baseFontSize,
        ),
      ],
    );
  }

  Widget _buildButton(
      String text, VoidCallback onPressed, double baseFontSize) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(vertical: baseFontSize * 0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: baseFontSize * 0.9,
            color: const Color(0xFF5E3023),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    final email = _emailController.text;
    final senha = _passwordController.text;

    print('in');

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira o e-mail e a senha')),
      );
      return;
    }

    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(email, senha);

      print('ok');

      context.go('/');
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail ou senha incorretos')),
      );
    }
  }

  void _navigateToSignup(BuildContext context) {
    context.go('/register');
  }
}
