import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary }

class AppButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final AppButtonVariant variant;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.secondary,
  });

  Color _getColor(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return variant == AppButtonVariant.secondary
        ? colorScheme.secondary
        : colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 1,
          color: _getColor(context),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // Bordas arredondadas
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 10,
        ),
        // Padding interno
        foregroundColor: _getColor(context),
        minimumSize: const Size(180, 30),
        elevation: 10,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color: _getColor(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
