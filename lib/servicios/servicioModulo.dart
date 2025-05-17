import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/modulo.dart';

class ModuloService {
  Future<ServiceHttpResponse?> fetchAll() async {
    List<Modulos> modulos = [];
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final String body =
        await rootBundle.loadString('assets/json/modulo.json');
    final List<dynamic> data = jsonDecode(body);
    modulos =
        data.map((map) => Modulos.fromJson(map as Map<String, dynamic>)).toList();
    serviceResponse.status = 200;
    print(modulos);
    serviceResponse.body = modulos;
    return serviceResponse;
  }
}

