import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  final Widget body;
  final String title;

  const AppDrawer({
    super.key,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF4D281E),  
          padding:  EdgeInsets.zero,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(height: 150),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white), 
                title: const Text(
                  'Receitas',
                  style: TextStyle(color: Colors.white), 
                ),
                onTap: () {
                  context.go('/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white), 
                title: const Text(
                  'Perfil',
                  style: TextStyle(color: Colors.white), 
                ),
                onTap: () {
                  context.go('/perfil');
                },
              ),
            ],
          ),
        ),
      ),
      body: body, // O conteúdo principal da tela
    );
  }
}
