import 'package:flutter/material.dart';
import 'package:gourmetize/widgets/app_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppDrawer(
      title: '',
      body: Center(
        child: Text('Aqui estarão as receitas', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
