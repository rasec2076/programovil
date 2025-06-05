import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/pages/perfil/perfil_controller.dart';



class CuestionariocorrectoController extends GetxController {
  final PerfilController perfilController = Get.find<PerfilController>(); // Acceder al PerfilController

  // Función para navegar a la página principal y actualizar la experiencia
  void irPrincipal(BuildContext context, int experienciaGanada, int usuarioId) {
    // Actualizar la experiencia en el PerfilController
    perfilController.actualizarExperiencia(usuarioId, experienciaGanada);

    // Navegar a la página principal
    Navigator.pushNamed(context, '/Home',);
  }
}