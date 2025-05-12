import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_seminario1/data/usuario.dart';

class UsuarioService {
  Future<List<Usuario>> fetchAll() async {
    List<Usuario> usuario = [];
    final String response =
        await rootBundle.loadString("assets/json/usuario.json");
    final List<dynamic> data = jsonDecode(response);
    usuario = data
        .map((map) => Usuario.fromJson(map as Map<String, dynamic>))
        .toList();
    return usuario;
  }
}
