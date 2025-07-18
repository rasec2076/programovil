import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/data/http_error.dart';
import '../configs/back.dart';

class InsigniaNivelService {

  Future<ServiceHttpResponse?> verificarYAsignarInsignia(int idNivel, int idUsuario) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/asignar/$idUsuario/$idNivel');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final insignia = Medalla.fromJson(responseData['insignia']);
        final bool asignada = responseData['asignada'] ?? false;

        serviceResponse.status = 200;
        serviceResponse.body = {
          'insignia': insignia,
          'asignada': asignada,
        };
      } else {
        final responseData = json.decode(response.body);
        final error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print("❌ Error al obtener insignia por nivel: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }

Future<ServiceHttpResponse?> verificarLogrosEspeciales(int idUsuario, int idNivel) async {
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();
  final url = Uri.parse('$BASE_URL/api/asignar/logros/$idUsuario/$idNivel');

  try {
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final List<dynamic> lista = responseData['insignias'] ?? [];

      final List<Medalla> logros = lista.map((e) => Medalla.fromJson(e)).toList();

      serviceResponse.status = 200;
      serviceResponse.body = {
        'insignias': logros,
      };
    } else {
      final responseData = json.decode(response.body);
      final error = HttpError.fromJson(responseData);
      serviceResponse.status = response.statusCode;
      serviceResponse.body = error;
    }
  } catch (e) {
    print("❌ Error al verificar logros especiales: $e");
    serviceResponse.status = 500;
    serviceResponse.body = null;
  }

  return serviceResponse;
}

  


  
}