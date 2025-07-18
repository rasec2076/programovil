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

  ServiceHttpResponse? response = await usuarios.login(nombre, contrasena);
  
  if (response == null) {
    print('❌ No hay respuesta del servidor');
    return;
  }

  if (response.status == 200) {
    final responseData = response.body as Map<String, dynamic>;

    final token = responseData["token"];
    final usuarioMap = responseData["usuario"];
    final usuario = Usuario.fromJson(usuarioMap);

    // Guardamos tanto usuario como token
    sesion.setUsuario(usuario, authToken: token);

    Navigator.pushNamed(context, '/Home');

    Get.snackbar("Éxito", "Bienvenido ${usuario.usuario}", snackPosition: SnackPosition.TOP);
  } else {
    print('⚠️ Error en la respuesta del servidor: ${response.status}');
  }
}
  void irRegistro (BuildContext context){
      Navigator.pushNamed(context, '/Registrar');
  }

  void cambiarContrasena (BuildContext context){
      Navigator.pushNamed(context, '/Registrar');
  }

}