import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuarioprogreso.dart';


class UsuarioProgresoService {
Future<ServiceHttpResponse?> findProgresoPorUsuarioYNivel(int idUsuario, int idNivel) async {
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();
  List<UsuarioProgreso> todosLosProgresos = [];

  try {
    final String body = await rootBundle.loadString('assets/json/usuario_progreso.json');
    final List<dynamic> data = jsonDecode(body);
    todosLosProgresos = data
        .map((json) => UsuarioProgreso.fromJson(json as Map<String, dynamic>))
        .toList();

    // Filtrar por idusuario y idnivel
    final progresoFiltrado = todosLosProgresos.where(
      (p) => p.idusuario == idUsuario && p.idnivel == idNivel,
    ).toList();

    if (progresoFiltrado.isEmpty) {
      serviceResponse.status = 404;
      serviceResponse.body = [];
    } else {
      serviceResponse.status = 200;
      serviceResponse.body = progresoFiltrado.first;
    }
  } catch (e) {
    print('❌ Error al cargar usuario_progreso.json: $e');
    serviceResponse.status = 500;
    serviceResponse.body = 'Error al leer el archivo';
  }

  return serviceResponse;
}
}