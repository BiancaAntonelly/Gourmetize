import 'package:gourmetize/model/usuario.dart'; // Certifique-se de que a classe Usuario está definida

class Carrinho {
  final Usuario usuario; // Relacionamento com o usuário
  List<String> ingredientes; // Lista de ingredientes no carrinho

  Carrinho({
    required this.usuario,
    required this.ingredientes,
  });

  // Método para criar o carrinho a partir de um JSON (para desserializar)
  factory Carrinho.fromJson(Map<String, dynamic> json) {
    return Carrinho(
      usuario: Usuario.fromJson(json[
          'usuario']), // Supondo que a classe Usuario tenha o método fromJson
      ingredientes: List<String>.from(
          json['ingredientes'] ?? []), // Lista de ingredientes
    );
  }

  // Método para converter o carrinho em JSON (para serializar)
  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario.toJson(), // A classe Usuario deve ter o método toJson
      'ingredientes': ingredientes,
    };
  }
}
