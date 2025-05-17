import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/seccion.dart';




class SeccionService {
  Future<ServiceHttpResponse?> fetchAll() async {
    List<Seccion> seccion = [];
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final String body =
        await rootBundle.loadString('assets/json/seccion.json');
    final List<dynamic> data = jsonDecode(body);
    seccion =
        data.map((map) => Seccion.fromJson(map as Map<String, dynamic>)).toList();
    serviceResponse.status = 200;
    print(seccion);
    serviceResponse.body = seccion;
    return serviceResponse;
  }

 Future<ServiceHttpResponse?> findAll(int idmodulo) async {
  List<Seccion> todasLasSecciones = [];
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();

  final String body = await rootBundle.loadString('assets/json/seccion.json');
  final List<dynamic> data = jsonDecode(body);
  todasLasSecciones = data.map((map) => Seccion.fromJson(map as Map<String, dynamic>)).toList();

  // Filtrar solo las secciones del módulo que coincide con idmodulo
  List<Seccion> seccionesFiltradas = todasLasSecciones
      .where((sec) => sec.idmodulo == idmodulo)
      .toList();

  if (seccionesFiltradas.isEmpty) {
    serviceResponse.status = 404;
    serviceResponse.body = []; // No se encontraron secciones
  } else {
    serviceResponse.status = 200;
    serviceResponse.body = seccionesFiltradas; // Solo secciones que pertenecen al módulo
  }

  return serviceResponse;
}



}