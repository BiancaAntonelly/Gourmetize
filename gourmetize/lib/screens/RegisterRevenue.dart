import 'package:flutter/material.dart';
import 'package:gourmetize/widgets/app_drawer.dart';

class RegisterRevenue extends StatelessWidget {
  const RegisterRevenue({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppDrawer(
      title: 'Cadastrar Receita',
      body: Center(
        child: Text('Aqui estarão as receitas', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
