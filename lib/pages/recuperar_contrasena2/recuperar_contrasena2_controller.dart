import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/sesioncontroller.dart';

class RecuperarContrasena2Controller {
  final nuevaController = TextEditingController();
  final repetirController = TextEditingController();
  final SesionController sesionController = Get.find<SesionController>();

  Future<bool> cambiarContrasena() async {
    if (nuevaController.text != repetirController.text) {
      print("❌ Contraseñas no coinciden");
      return false;
    }

    final usuario = sesionController.getUsuario;
    if (usuario == null) {
      print("❌ No hay usuario en sesión");
      return false;
    }

    // Simula el cambio solo en memoria
    usuario.contrasena = nuevaController.text;
    sesionController.setUsuario(usuario);
    print("✅ Contraseña simulada para: ${usuario.correo}");
    return true;
  }

  void dispose() {
    nuevaController.dispose();
    repetirController.dispose();
  }
}
