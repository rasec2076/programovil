import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';


class PreguntaService {
  Future<ServiceHttpResponse?> fetchAll() async {
    List<Pregunta> preguntas = [];
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final String body =
        await rootBundle.loadString('assets/json/pregunta.json');
    final List<dynamic> data = jsonDecode(body);
    preguntas =
        data.map((map) => Pregunta.fromJson(map as Map<String, dynamic>)).toList();
    serviceResponse.status = 200;
    print(preguntas);
    serviceResponse.body = preguntas;
    return serviceResponse;
  }



  Future<ServiceHttpResponse?> findAllPreguntasPorNivel(int idnivel) async {
  List<Pregunta> todasLasPreguntas = [];
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();

  final String body = await rootBundle.loadString('assets/json/pregunta.json');
  final List<dynamic> data = jsonDecode(body);

  // Convertir JSON a objetos Pregunta
  todasLasPreguntas = data
      .map((map) => Pregunta.fromJson(map as Map<String, dynamic>))
      .toList();

  // Filtrar preguntas por nivel
  List<Pregunta> preguntasFiltradas = todasLasPreguntas
      .where((pregunta) => pregunta.idNivel == idnivel)
      .toList();

  if (preguntasFiltradas.isEmpty) {
    serviceResponse.status = 404;
    serviceResponse.body = [];
  } else {
    serviceResponse.status = 200;
    serviceResponse.body = preguntasFiltradas;
  }

  return serviceResponse;
}
}
