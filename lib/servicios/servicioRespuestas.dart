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
}
