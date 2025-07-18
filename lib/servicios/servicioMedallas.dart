import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_seminario1/data/http_error.dart';
import '../configs/back.dart';


class MedallaService {
  Future<ServiceHttpResponse?> verInsigniasDeUsuario(int idUsuario) async {
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();
  final url = Uri.parse('$BASE_URL/api/insignias/usuario/$idUsuario');

  try {
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Si el backend devuelve solo un mensaje, no hay insignias
      if (responseData is Map && responseData.containsKey('mensaje')) {
        serviceResponse.status = 200;
        serviceResponse.body = [];
      } else {
        final List<dynamic> listaJson = responseData;
        final insignias = listaJson.map((e) => Medalla.fromJson(e)).toList();

        serviceResponse.status = 200;
        serviceResponse.body = insignias;
      }
    } else {
      final responseData = json.decode(response.body);
      final error = HttpError.fromJson(responseData);
      serviceResponse.status = response.statusCode;
      serviceResponse.body = error;
    }
  } catch (e) {
    print("❌ Error al obtener insignias del usuario: $e");
    serviceResponse.status = 500;
    serviceResponse.body = null;
  }

  return serviceResponse;
}

}