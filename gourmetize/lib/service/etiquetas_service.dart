import 'dart:convert';

import 'package:gourmetize/config/app_config.dart';
import 'package:gourmetize/model/etiqueta.dart';
import 'package:http/http.dart' as http;

class EtiquetasService {
  final String _baseUrl = AppConfig.baseUrl + '/etiquetas';

  Future<Etiqueta> createEtiqueta(Etiqueta etiqueta) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode(etiqueta.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      print(etiqueta.toJson());

      throw Exception("Erro ao criar etiqueta");
    }

    return Etiqueta.fromJson(jsonDecode(response.body));
  }
}
