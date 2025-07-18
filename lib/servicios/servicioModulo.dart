import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/modulo.dart';
import 'package:prueba_seminario1/data/http_error.dart';
import '../configs/back.dart';

class ModuloService {
  Future<ServiceHttpResponse?> findAllModulos() async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/modulos/');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List<Modulos> modulos = (responseData['data'] as List)
            .map((e) => Modulos.fromJson(e))
            .toList();

        serviceResponse.status = 200;
        serviceResponse.body = modulos;
      } else {
        final responseData = json.decode(response.body);
        HttpError error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print("Error al conectar con el backend: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }

  Future<ServiceHttpResponse?> findEstructuraCompleta(int idModulo) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/modulos/$idModulo');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        serviceResponse.status = 200;
        serviceResponse.body = responseData['data']; // lista de objetos con type = section o nivel
      } else {
        final responseData = json.decode(response.body);
        HttpError error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print("Error al conectar con el backend: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }

}

