import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/servicios/servicioNivelinsignias.dart';

class CuestionariocorrectoController extends GetxController {

  final InsigniaNivelService asignarservicio  = InsigniaNivelService();

  void GanasteInsignia(BuildContext context, int usuarioId, int idNivel) async {
    
    final response = await asignarservicio.verificarYAsignarInsignia(idNivel, usuarioId);

    if (response != null && response.status == 200 && response.body is Map) {
      final medalla = response.body['insignia'] as Medalla;
      final bool asignada = response.body['asignada'] ?? false;

      if (asignada) {
        Navigator.pushNamed(
          context,
          '/darinsignia',
          arguments: {
            'usuarioid':usuarioId,
            'nivel': idNivel,
            'insignia': medalla,
            'asignada': true,
          },
        );
      } else {
        Navigator.pushNamed(context, '/Home');
      }
    } else {
      Get.snackbar('Error', 'No se pudo obtener la insignia');
      Navigator.pushNamed(context, '/Home');
    }
  }
}