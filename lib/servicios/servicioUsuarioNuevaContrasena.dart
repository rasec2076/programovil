import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:prueba_seminario1/data/usuario.dart';

class UsuarioServiceNuevaContrasena {
  Future<List<Usuario>> _leerUsuarios() async {
    final body = await rootBundle.loadString('assets/json/usuario.json');
    final List<dynamic> data = jsonDecode(body);
    return data.map((e) => Usuario.fromJson(e)).toList();
  }

  Future<Usuario?> buscarUsuarioPorCorreo(String correo) async {
    final lista = await _leerUsuarios();
    try {
      return lista.firstWhere((u) => u.correo == correo);
    } catch (_) {
      return null;
    }
  }
}
