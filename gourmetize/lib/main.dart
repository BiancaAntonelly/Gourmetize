import 'package:flutter/material.dart';
import 'package:gourmetize/routes/routes.dart';

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: myRouter,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 20.0),
          bodyLarge: TextStyle(fontSize: 24.0),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFFCC00),
          secondary: const Color(0xFF4D281E),
        ),
        primaryColor: const Color(
          0xFFFFCC00,
        ),
        secondaryHeaderColor: const Color(0xFF4D281E),
      ),
    ),
  );
}
