import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';


class RespuestaService {
  Future<ServiceHttpResponse?> fetchAll() async {
    List<Respuesta> respuestas = [];
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final String body =
        await rootBundle.loadString('assets/json/respuesta.json');
    final List<dynamic> data = jsonDecode(body);
    respuestas =
        data.map((map) => Respuesta.fromJson(map as Map<String, dynamic>)).toList();
    serviceResponse.status = 200;
    print(respuestas);
    serviceResponse.body = respuestas;
    return serviceResponse;
  }

  Future<ServiceHttpResponse?> findAllRespuestasPorPregunta(int idpregunta) async {
  List<Respuesta> todasLasRespuestas = [];
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();

  final String body = await rootBundle.loadString('assets/json/respuesta.json');
  final List<dynamic> data = jsonDecode(body);

  // Convertir JSON a objetos Pregunta
  todasLasRespuestas = data
      .map((map) => Respuesta.fromJson(map as Map<String, dynamic>))
      .toList();

  // Filtrar preguntas por nivel
  List<Respuesta> respuestasFiltradas = todasLasRespuestas
      .where((respuesta) => respuesta.idPregunta == idpregunta)
      .toList();

  if (respuestasFiltradas.isEmpty) {
    serviceResponse.status = 404;
    serviceResponse.body = [];
  } else {
    serviceResponse.status = 200;
    serviceResponse.body = respuestasFiltradas;
  }

  return serviceResponse;
}
}
