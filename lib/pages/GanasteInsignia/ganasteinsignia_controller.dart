import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/servicios/servicioNivelinsignias.dart';

class GanasteinsigniaController extends GetxController {
  final InsigniaNivelService asignarservicio = InsigniaNivelService();

  void irPrincipal(BuildContext context) {
    Navigator.pushNamed(context, '/Home');
  }

  void verificarLogrosYRedirigir(BuildContext context, int usuarioId, int idNivel) async {
    final response = await asignarservicio.verificarLogrosEspeciales(usuarioId ,idNivel);

    if (response != null && response.status == 200 && response.body is Map) {
      final List<dynamic> lista = response.body['insignias'] ?? [];
      if (lista.isNotEmpty) {
        final logros = lista.map((e) => Medalla.fromJson(e)).toList();

        Navigator.pushNamed(
          context,
          '/ganastelogro',
          arguments: {
            'logros': logros,
          },
        );
        return;
      }
    }

    // Si no hay logros o falla la respuesta, redirige a Home
    Navigator.pushNamed(context, '/Home');
  }
}
