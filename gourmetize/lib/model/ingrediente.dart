class Ingrediente {
  String ingredient;
  String unidade;
  double quantidade;

  Ingrediente(
      {required this.ingredient,
      required this.unidade,
      required this.quantidade});

  Map<String, dynamic> toJson() {
    return {
      'ingredient': ingredient,
      'unidade': unidade,
      'quantidade': quantidade,
    };
  }

  factory Ingrediente.fromJson(Map<String, dynamic> json) {
    return Ingrediente(
      ingredient: json['ingredient'],
      unidade: json['unidade'],
      quantidade: json['quantidade'],
    );
  }
}
