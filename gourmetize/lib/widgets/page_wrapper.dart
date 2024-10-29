import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum PageWrapperButtonType {
  drawer,
  back;
}

class PageWrapper extends StatelessWidget {
  final Widget body;
  final String title;
  final FloatingActionButton? floatingActionButton;
  final PageWrapperButtonType pageWrapperButtonType;

  const PageWrapper(
      {super.key,
      required this.body,
      required this.title,
      this.floatingActionButton,
      this.pageWrapperButtonType = PageWrapperButtonType.drawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: const Color.fromRGBO(255, 204, 0, 100),
        shadowColor: Colors.grey,
        surfaceTintColor: const Color.fromRGBO(163, 101, 83, 100),
        automaticallyImplyLeading: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                  pageWrapperButtonType == PageWrapperButtonType.drawer
                      ? Icons.menu
                      : Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: () {
                if (pageWrapperButtonType == PageWrapperButtonType.drawer) {
                  Scaffold.of(context).openDrawer();
                } else {
                  context.pop();
                }
              },
            );
          },
        ),
        actions: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
            child: Image.asset(
              'assets/icone.png',
              fit: BoxFit.cover,
              height: 34,
              width: 30,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.zero,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(height: 150),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/person.svg',
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
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/home.svg',
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
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/all_recipies.svg',
                  width: 28,
                  height: 28,
                ),
                title: const Text(
                  'Todas as receitas',
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
                leading: SvgPicture.asset(
                  'assets/revenues.svg',
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
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: SvgPicture.asset(
                    'assets/my_recipes.svg',
                    width: 21,
                    height: 16,
                  ),
                ),
                title: const Text(
                  'Minhas receitas',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  context.go('/receitas-usuario');
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: SvgPicture.asset(
                    'assets/register_recipe.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                title: const Text(
                  'Cadastrar receitas',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                onTap: () {
                  context.push('/cadastrar-receita');
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/logout.svg',
                  width: 28,
                  height: 28,
                ),
                title: const Text(
                  'Sair',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
