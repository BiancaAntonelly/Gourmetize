import 'package:gourmetize_app/model/receita.dart';


class ReceitaService {

    final String _baseUrl = 'http://127.0.0.1:8080/receitas';

    Future<List<Receita>> buscarReceitas() async {
        // Mockado por enquanto
        
        return [];
    }

    Future<void> adicionarReceita(Receita receita) async {
        // Implementar
    }

    Future<void> removerReceita(Receita receita) async {
        // Implementar
    }

    Future<void> atualizarReceita(Receita receita) async {
        // Implementar
    }
}
 