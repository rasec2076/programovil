import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/servicios/servicioUsuario.dart';

class EditarUsuarioController {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  int? generoSeleccionado;
  final UsuarioService usuarioservice = UsuarioService(); 

  void cargarUsuario(Usuario usuario) {
    nombreController.text = usuario.usuario;
    correoController.text = usuario.correo;
    edadController.text = usuario.edad.toString();
    generoSeleccionado = usuario.idgenero;
  }

Future<bool> actualizarUsuario() async {
  // Paso 1: Obtener token desde la sesión
  final sesion = Get.find<SesionController>();
  final token = sesion.getToken;

  if (token == null) {
    print("⚠️ No hay token en sesión");
    return false;
  }

  // Recoger los valores del formulario
  final usuario = nombreController.text.trim();
  final correo = correoController.text.trim();
  final edad = int.tryParse(edadController.text.trim()) ?? 0;
  final generoId = generoSeleccionado ?? 1 ;

  // Llamar al servicio
  final response = await usuarioservice.actualizarUsuario(
    token: token,
    usuario: usuario,
    correo: correo,
    edad: edad,
    generoId: generoId,
  );

  // Si fue exitoso, actualiza el usuario en la sesión
  if (response != null && response.status == 200) {
    await sesion.actualizardatos(); // <- opcional, si quieres refrescar la sesión
    return true;
  } else {
    return false;
  }
}

}


