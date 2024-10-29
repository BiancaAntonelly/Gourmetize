import 'package:flutter/material.dart';
import 'package:gourmetize/widgets/page_wrapper.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      title: 'Perfil',
      body: Center(
        child: Text('Perfil', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
