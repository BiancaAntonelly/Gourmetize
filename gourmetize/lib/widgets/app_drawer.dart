import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/screens/nova_avaliacao.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    void openNovaAvaliacao() {
      showModalBottomSheet(
        context: context,
        builder: (context) => NovaAvaliacao(),
        backgroundColor: Colors.transparent,
      );
    }

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
          padding: EdgeInsets.zero,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(height: 150),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/person.svg',
                  color: Colors.white,
                  width: 28,
                  height: 28,
                ),
                title: const Text(
                  'Meu perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  context.go('/perfil');
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/home.svg',
                  color: Colors.white,
                  width: 28,
                  height: 28,
                ),
                title: const Text(
                  'Tela inicial',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  context.go('/login');
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/all_recipies.svg',
                  color: Colors.white,
                  width: 28,
                  height: 28,
                ),
                title: const Text(
                  'Todas receitas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  context.go('/perfil');
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/revenues.svg',
                  color: Colors.white,
                  width: 28,
                  height: 28,
                ),
                title: const Text(
                  'Receitas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  context.go('/');
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: SvgPicture.asset(
                    'assets/my_recipes.svg',
                    color: Colors.white,
                    width: 21,
                    height: 16,
                  ),
                ),
                title: const Text(
                  'Minhas receitas',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  // Navegar para a página de Minhas receitas
                },
              ),
              ListTile(
                leading: Padding(
                    padding: const EdgeInsets.only(left: 36.0),
                    child: SvgPicture.asset(
                      'assets/register_recipe.svg',
                      color: Colors.white,
                      width: 24,
                      height: 24,
                    )),
                title: const Text(
                  'Cadastrar receitas',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  context.go('/cadastrar-receita');
                },
              ),
              const SizedBox(height: 4),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  // Adiciona espaço à esquerda
                  child: SvgPicture.asset(
                    'assets/my_reviews.svg',
                    color: Colors.white,
                    width: 24,
                    height: 24,
                  ),
                ),
                title: const Text(
                  'Minhas avaliações',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: openNovaAvaliacao,
        child: Icon(Icons.star, color: Colors.yellow),
      ), // O conteúdo principal da tela
    );
  }
}
