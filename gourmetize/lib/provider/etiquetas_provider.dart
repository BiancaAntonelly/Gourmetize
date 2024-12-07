import 'package:flutter/material.dart';
import 'package:gourmetize/model/etiqueta.dart';
import 'package:gourmetize/service/etiquetas_service.dart';
import 'package:gourmetize/service/usuario_service.dart';

class EtiquetasProvider with ChangeNotifier {
  List<Etiqueta> _etiquetas = [];
  EtiquetasService _etiquetasService = EtiquetasService();
  UsuarioService _usuarioService = UsuarioService();

  List<Etiqueta> get etiquetas => [..._etiquetas];

  Future<Etiqueta> createEtiqueta(Etiqueta etiqueta) async {
    final created = await _etiquetasService.createEtiqueta(etiqueta);

    _etiquetas.add(created);

    notifyListeners();

    return created;
  }

  Future<List<Etiqueta>> getEtiquetas(int usuarioId) async {
    _etiquetas = await _usuarioService.getEtiquetas(usuarioId);

    notifyListeners();

    return _etiquetas;
  }
}
