import 'package:flutter/material.dart';
import 'package:gourmetize/routes/routes.dart';

void main(){
    runApp(MaterialApp.router(
      routerConfig: myRouter,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 16.0), 
          bodyMedium: TextStyle(fontSize: 20.0),
          bodyLarge: TextStyle(fontSize: 24.0),
        ),
      ),
    ),
  );
}