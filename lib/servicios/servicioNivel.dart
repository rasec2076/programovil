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

Future<ServiceHttpResponse?> findAllNiveles(int idseccion) async {
  List<Nivel> todosLosNiveles = [];
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();

  final String body = await rootBundle.loadString('assets/json/niveles.json');
  final List<dynamic> data = jsonDecode(body);
  todosLosNiveles = data.map((map) => Nivel.fromJson(map as Map<String, dynamic>)).toList();

  List<Nivel> nivelesFiltrados = todosLosNiveles
      .where((nivel) => nivel.idseccion == idseccion)
      .toList();

  if (nivelesFiltrados.isEmpty) {
    serviceResponse.status = 404;
    serviceResponse.body = [];
  } else {
    serviceResponse.status = 200;
    serviceResponse.body = nivelesFiltrados;
  }

  return serviceResponse;
}


}