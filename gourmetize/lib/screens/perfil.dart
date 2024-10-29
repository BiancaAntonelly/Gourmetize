import 'package:flutter/material.dart';
import 'package:gourmetize/model/usuario.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/page_wrapper.dart';

class Perfil extends StatelessWidget {
  final void Function() onDeslogarUsuario;
  const Perfil(
      {super.key,
      required this.usuarioLogado,
      required this.onDeslogarUsuario});
  final Usuario usuarioLogado;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Perfil',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações do Usuário',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(usuarioLogado.nome,
                  style: const TextStyle(fontSize: 20)),
              subtitle: const Text('Nome'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(usuarioLogado.email,
                  style: const TextStyle(fontSize: 20)),
              subtitle: const Text('Email'),
            ),
            const Divider(height: 32),
            Text(
              'Receitas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usuarioLogado.receitas.length,
                itemBuilder: (context, index) {
                  final receita = usuarioLogado.receitas[index];
                  return ListTile(
                    leading: const Icon(Icons.fastfood),
                    title: Text(receita.titulo),
                    subtitle: Text(receita.descricao),
                  );
                },
              ),
            ),
            const Divider(height: 32),
            Text(
              'Etiquetas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usuarioLogado.etiquetas.length,
                itemBuilder: (context, index) {
                  final etiqueta = usuarioLogado.etiquetas[index];
                  return ListTile(
                    leading: const Icon(Icons.label),
                    title: Text(etiqueta
                        .nome), // Supondo que etiqueta tem um atributo nome
                  );
                },
              ),
            ),
            const Divider(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onDeslogarUsuario();
                  context.go('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor do botão
                ),
                child: const Text('Deslogar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
