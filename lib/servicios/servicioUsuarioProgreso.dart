import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/http_error.dart';
import 'package:prueba_seminario1/data/usuarioprogreso.dart';
import '../configs/back.dart';

class UsuarioProgresoService {
  Future<ServiceHttpResponse?> findProgresoPorUsuarioYNivel(int idUsuario, int idNivel) async {
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();
  final url = Uri.parse('$BASE_URL/api/progreso/');

  try {
    final request = http.Request('GET', url)
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({"id_usuario": idUsuario, "id_nivel": idNivel});

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      serviceResponse.status = 200;
      serviceResponse.body = UsuarioProgreso.fromJson(responseData['data']);
    } else {
      serviceResponse.status = response.statusCode;
      serviceResponse.body = HttpError.fromJson(responseData);
    }
  } catch (e) {
    print("❌ Error al obtener progreso: $e");
    serviceResponse.status = 500;
    serviceResponse.body = null;
  }

  return serviceResponse;
}

Future<ServiceHttpResponse?> crearProgreso(int idUsuario, int idNivel) async {
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();
  final url = Uri.parse('$BASE_URL/api/progreso/$idUsuario/$idNivel');

  try {
    final response = await http.post( 
      url,
      headers: {'Content-Type': 'application/json'},
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      serviceResponse.status = response.statusCode;
      serviceResponse.body = UsuarioProgreso.fromJson(responseData['data']);
    } else {
      serviceResponse.status = response.statusCode;
      serviceResponse.body = HttpError.fromJson(responseData);
    }
  } catch (e) {
    print("❌ Error al crear progreso: $e");
    serviceResponse.status = 500;
    serviceResponse.body = null;
  }

  return serviceResponse;
}
}