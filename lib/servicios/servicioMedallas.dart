import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';

class MedallaService {
  Future<ServiceHttpResponse?> fetchAll() async {
    List<Medalla> medallas = [];
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();

    try {
      final String body = await rootBundle.loadString('assets/json/insignias.json');
      final List<dynamic> data = jsonDecode(body);

      medallas = data
          .map((map) => Medalla.fromJson(map as Map<String, dynamic>))
          .toList();

      serviceResponse.status = 200;
      serviceResponse.body = medallas;
    } catch (e) {
      serviceResponse.status = 500;
      serviceResponse.body = 'Error al cargar medallas: $e';
    }

    return serviceResponse;
  }
}