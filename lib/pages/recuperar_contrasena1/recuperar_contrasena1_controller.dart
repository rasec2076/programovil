import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/sesioncontroller.dart';
import '../../servicios/servicioUsuarioNuevaContrasena.dart';

class RecuperarContrasena1Controller {
  final correoController = TextEditingController();
  final servicioUsuario = UsuarioServiceNuevaContrasena();
  final SesionController sesionController = Get.find<SesionController>();

  Future<bool> validarCorreo() async {
    final usuario = await servicioUsuario.buscarUsuarioPorCorreo(correoController.text);
    if (usuario != null) {
      sesionController.setUsuario(usuario);
      return true;
    }
    return false;
  }

  void dispose() {
    correoController.dispose();
  }
}
