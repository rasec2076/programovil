import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/principal/principal.dart';
import 'package:prueba_seminario1/servicios/servicioUsuario.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';

class LoginController extends GetxController {
  final nombreController = TextEditingController();
  final contrasenaController = TextEditingController();

  final  UsuarioService usuarios = UsuarioService();
  final SesionController sesion = Get.put(SesionController());

  Future<void> login(BuildContext context) async {
    final nombre = nombreController.text.trim();
    final contrasena = contrasenaController.text.trim();

    ServiceHttpResponse? response = await usuarios.fetchAll(nombre, contrasena);

    if(response == null){
      print('no hay respuesta del servidor');
    }else{
      if(response.status== 200){
        Usuario user = response.body;
        sesion.setUsuario(user);
        Navigator.pushNamed(context,'/principal');
        Get.snackbar("Éxito", "Bienvenido ${user.nombre}",
          snackPosition: SnackPosition.TOP);

      }else{
        print('error en la respuesta de servidor');
      }
    }

    
  }

  void irRegistro (BuildContext context){
      Navigator.pushNamed(context, '/Registrar');
  }

  void cambiarContrasena (BuildContext context){
      Navigator.pushNamed(context, '/Registrar');
  }

}