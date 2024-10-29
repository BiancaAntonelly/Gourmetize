import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final Color iconColor; // Cor que será aplicada ao ícone

  const LogoWidget({
    Key? key,
    required this.size,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icone.png', // O ícone que será colorido
      height: size,
      fit: BoxFit.cover,
      color: iconColor, // Aplica a cor fornecida ao ícone
      colorBlendMode: BlendMode.srcIn, // Define o modo de mistura da cor
    );
  }
}
