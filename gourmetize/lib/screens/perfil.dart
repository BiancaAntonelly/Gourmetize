import 'package:flutter/material.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/page_wrapper.dart';

class Perfil extends StatelessWidget {
  final void Function() onDeslogarUsuario;
  final Usuario usuarioLogado;

  const Perfil({
    super.key,
    required this.usuarioLogado,
    required this.onDeslogarUsuario,
  });

  @override
  Widget build(BuildContext context) {
    // Obter largura e altura da tela
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return PageWrapper(
      title: 'Perfil',
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),
            CircleAvatar(
              radius: screenWidth * 0.18,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.person,
                size: screenWidth * 0.15,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              usuarioLogado.nome,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: screenWidth * 0.06,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              usuarioLogado.email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: screenWidth * 0.045,
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
            Divider(height: screenHeight * 0.05, thickness: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
              child: ElevatedButton.icon(
                onPressed: () {
                  onDeslogarUsuario();
                  context.go('/login');
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Sair',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.5, screenHeight * 0.06),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
