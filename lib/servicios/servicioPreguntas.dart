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
}
