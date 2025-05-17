import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/nivel.dart';




class NivelService {
  Future<ServiceHttpResponse?> fetchAll() async {
    List<Nivel> niveles = [];
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final String body =
        await rootBundle.loadString('assets/json/niveles.json');
    final List<dynamic> data = jsonDecode(body);
    niveles =
        data.map((map) => Nivel.fromJson(map as Map<String, dynamic>)).toList();
        print("+++++++++++++++++++++++++++++++++++++++++");
    serviceResponse.status = 200;
    print(niveles);
    serviceResponse.body = niveles;
    return serviceResponse;
  }

  Future<ServiceHttpResponse?> findAll(int idseccion) async {
  List<Nivel> todasLasSecciones = [];
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();

  final String body = await rootBundle.loadString('assets/json/niveles.json');
  final List<dynamic> data = jsonDecode(body);
  todasLasSecciones = data.map((map) => Nivel.fromJson(map as Map<String, dynamic>)).toList();

  // Filtrar solo las secciones del módulo que coincide con idmodulo
  List<Nivel> nivelesfiltrados = todasLasSecciones
      .where((nivel) => nivel.idseccion == idseccion)
      .toList();

  if (nivelesfiltrados.isEmpty) {
    serviceResponse.status = 404;
    serviceResponse.body = []; // No se encontraron secciones
  } else {
    serviceResponse.status = 200;
    serviceResponse.body = nivelesfiltrados; // Solo secciones que pertenecen al módulo
  }

  return serviceResponse;
}


}