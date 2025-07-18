
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_seminario1/data/usuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/http_error.dart';
import '../configs/back.dart';

class UsuarioService {
  Future<ServiceHttpResponse?> login(String usuario, String contrasenia) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/usuarios/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'usuario': usuario,
          'contrasenia': contrasenia,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final token = responseData['token'];
        final user = responseData['usuario'];

        serviceResponse.status = 200;
        serviceResponse.body = {
          'token': token,
          'usuario':user,
        };
      } else {
        final error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print("❌ Error en login: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }


   Future<ServiceHttpResponse?> crearCuenta(Usuario usuario) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/usuarios/crear-cuenta');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'usuario': usuario.usuario,
          'correo': usuario.correo,
          'contrasenia': usuario.contrasena,
          'edad': usuario.edad,
          'generoId': usuario.idgenero,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        serviceResponse.status = 201;
        serviceResponse.body = responseData;
      } else {
        serviceResponse.status = response.statusCode;
        serviceResponse.body = HttpError.fromJson(responseData);
      }
    } catch (e) {
      print("❌ Error al crear cuenta: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }

  Future<ServiceHttpResponse?> obtenerTodosLosUsuarios() async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/usuarios');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final usuarios = responseData.map((json) => Usuario.fromJson(json)).toList();

        serviceResponse.status = 200;
        serviceResponse.body = usuarios;
      } else {
        final responseData = json.decode(response.body);
        final error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print("❌ Error al obtener usuarios: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }

  Future<ServiceHttpResponse?> obtenerUsuarioPorId(int id, String token) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/usuarios/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // si la ruta está protegida con JWT
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final usuario = Usuario.fromJson(responseData);

        serviceResponse.status = 200;
        serviceResponse.body = usuario;
      } else {
        final responseData = json.decode(response.body);
        final error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print("❌ Error al obtener usuario: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }


  Future<ServiceHttpResponse?> actualizarUsuario({
    required String token,
    required String usuario,
    required String correo,
    required int edad,
    required int generoId,
  }) async {
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    final url = Uri.parse('$BASE_URL/api/usuarios/actualizar-usuario');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'usuario': usuario,
          'correo': correo,
          'edad': edad,
          'generoId': generoId,
        }),
      );

      if (response.statusCode == 200) {
        serviceResponse.status = 200;
        serviceResponse.body = {"mensaje": "Usuario actualizado correctamente"};
      } else {
        final responseData = json.decode(response.body);
        final error = HttpError.fromJson(responseData);
        serviceResponse.status = response.statusCode;
        serviceResponse.body = error;
      }
    } catch (e) {
      print("❌ Error al actualizar usuario: $e");
      serviceResponse.status = 500;
      serviceResponse.body = null;
    }

    return serviceResponse;
  }

Future<ServiceHttpResponse?> obtenerPerfil(String token) async {
  ServiceHttpResponse serviceResponse = ServiceHttpResponse();
  final url = Uri.parse('$BASE_URL/api/usuarios/perfil');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final usuario = Usuario.fromJson(jsonData);

      serviceResponse.status = 200;
      serviceResponse.body = usuario;
    } else {
      final error = HttpError.fromJson(json.decode(response.body));
      serviceResponse.status = response.statusCode;
      serviceResponse.body = error;
    }
  } catch (e) {
    print("❌ Error al obtener perfil: $e");
    serviceResponse.status = 500;
    serviceResponse.body = null;
  }

  return serviceResponse;
}
  
}



/* 
usuaurio correcto
{
  status: 200,
  body: {usuario_id: 2}
}

usuaurio incorrecto
{
  status: 400,
  body: ''
}

usuaurio incorrecto
{
  status: 500,
  body: ''
}

null

*/