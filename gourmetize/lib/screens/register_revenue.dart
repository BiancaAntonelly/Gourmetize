import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetize/widgets/app_drawer.dart';

class RegisterRevenue extends StatelessWidget {
  final Function(String, String, String, String) onCadastrarReceita;

  const RegisterRevenue({super.key, required this.onCadastrarReceita});

  @override
  Widget build(BuildContext context) {
    // Controladores para capturar os inputs do formulário
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController ingredientesController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    final TextEditingController preparoController = TextEditingController();

    return AppDrawer(
      title: 'Cadastrar Receita',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Título da receita:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(
                  hintText: 'Digite o título da sua receita',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingredientes:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: ingredientesController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Informe os ingredientes separados por uma quebra de linha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Descrição:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: descricaoController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Informe uma breve descrição para ser mostrada na listagem de receitas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Modo de preparo:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: preparoController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Informe o modo de preparo da sua receita separando os passos por uma quebra de linha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Chamando a função callback ao pressionar o botão
                    onCadastrarReceita(
                      tituloController.text,
                      ingredientesController.text,
                      descricaoController.text,
                      preparoController.text,
                    );

                    // Redirecionar para a tela inicial após o cadastro
                    GoRouter.of(context).go('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
