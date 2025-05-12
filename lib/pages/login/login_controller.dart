import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/pages/principal/principal.dart';

class LoginController extends GetxController {
  final nombreController = TextEditingController();
  final contrasenaController = TextEditingController();

  void login(BuildContext context) {
    final nombre = nombreController.text.trim();
    final contrasena = contrasenaController.text.trim();

    // Aquí puedes hacer la validación real (ej. API o datos locales)
    if (nombre == "admin" && contrasena == "1234") {
      Get.snackbar("Éxito", "Inicio de sesión correcto",
          snackPosition: SnackPosition.TOP);
      Get.to(() =>  Principal());
    } else {
      Get.snackbar("Error", "Nombre o contraseña incorrectos",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}