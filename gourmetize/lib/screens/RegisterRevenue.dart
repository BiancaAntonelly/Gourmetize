import 'package:flutter/material.dart';
import 'package:gourmetize/widgets/app_drawer.dart';

class RegisterRevenue extends StatelessWidget {
  const RegisterRevenue({super.key});

  @override
  Widget build(BuildContext context) {
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
                decoration: InputDecoration(
                  hintText: 'Digite o título da sua receita',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown), // Borda quando não focada
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.brown, width: 2), // Borda quando focada
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
                maxLines: 4,
                decoration: InputDecoration(
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
                maxLines: 4,
                decoration: InputDecoration(
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
                maxLines: 4,
                decoration: InputDecoration(
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
                    // Ação de cadastrar receita
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown, // Cor do botão
                    padding: EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Tamanho do botão
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
