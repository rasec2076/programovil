import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';

class UsuarioService {
  Future<ServiceHttpResponse?> fetchAll(String usuario, String contrasenia) async {
    List<Usuario> usuarios = [];
    ServiceHttpResponse serviceResponse = ServiceHttpResponse();
    // inicio logica servidor
    final String body =
        await rootBundle.loadString('assets/json/usuario.json');
    final List<dynamic> data = jsonDecode(body);
    usuarios =
        data.map((map) => Usuario.fromJson(map as Map<String, dynamic>)).toList();
    // vierificar que usuario y contraseña sean validos
    bool validos = false;
    Usuario? userLogeuado = null;
    for (var user in usuarios) {
      if(user.nombre == usuario && user.contrasena == contrasenia){
        validos = true;
        userLogeuado = user;
      }
    }
    if (validos == false){
      serviceResponse.status = 400;
      serviceResponse.body = '';
    }else{
      serviceResponse.body = userLogeuado;
      serviceResponse.status = 200;
    }
    // fin logica servidorv
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