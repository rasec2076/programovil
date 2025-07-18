import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/http_error.dart';
import '../configs/back.dart';


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


Future<ServiceHttpResponse?> findAllCuestionarioporNivel(int idNivel) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/cuestionarios/$idNivel');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        Nivel nivel = Nivel.fromJson(responseData['nivel']);

        List<Pregunta> preguntas = (responseData['preguntas'] as List)
            .map((e) => Pregunta.fromJson(e))
            .toList();

        List<Respuesta> respuestas = (responseData['respuestas'] as List)
            .map((e) => Respuesta.fromJson(e))
            .toList();

        serviceResponse.status = 200;
        serviceResponse.body = {
          "nivel": nivel,
          "preguntas": preguntas,
          "respuestas": respuestas,
        };
      } else {
        final responseData = json.decode(response.body);
        HttpError error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print('Error al conectar con el backend: $e');
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }

  Future<ServiceHttpResponse?> responderPregunta({
  required int idUsuario,
  required int idNivel,
  required int idRespuesta,
  }) async {
  
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();
  final url = Uri.parse('$BASE_URL/api/cuestionarios/responder');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_usuario': idUsuario,
        'id_nivel': idNivel,
        'idrespuesta': idRespuesta,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      serviceResponse.status = 200;
      serviceResponse.body = responseData; // Devuelve todo el JSON tal cual
    } else {
      final responseData = json.decode(response.body);
      HttpError error = HttpError.fromJson(responseData);
      serviceResponse.status = response.statusCode;
      serviceResponse.body = error;
    }
  } catch (e) {
    print('Error al enviar respuesta: $e');
    serviceResponse.status = 500;
    serviceResponse.body = null;
  }

  return serviceResponse;
}

Future<ServiceHttpResponse?> reiniciarCuestionario({
  required int idUsuario,
  required int idNivel,
}) async {
  final url = Uri.parse('$BASE_URL/api/cuestionarios/reiniciar');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id_usuario': idUsuario,
        'id_nivel': idNivel,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return ServiceHttpResponse(status: 200, body: responseData);
    } else {
      final responseData = json.decode(response.body);
      return ServiceHttpResponse(status: response.statusCode, body: responseData);
    }
  } catch (e) {
    print('Error al reiniciar cuestionario: $e');
    return ServiceHttpResponse(status: 500, body: null);
  }
}
}
