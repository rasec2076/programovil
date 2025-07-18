import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/GanasteInsignia/ganasteinsignia_controller.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/pages/Insignias/insignias_controller.dart';

class Ganasteinsignia extends StatelessWidget {
  Ganasteinsignia({super.key});

  final GanasteinsigniaController control = Get.put(GanasteinsigniaController());
  final InsigniaController insigniaController = Get.find<InsigniaController>();
  final sesion = Get.find<SesionController>();

  @override
  Widget build(BuildContext context) {
    final Usuario? user = sesion.getUsuario;
    insigniaController.cargarInsignias(user!.id);

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final Medalla? insignia = args?['insignia'];
    final int? usuarioId = args?['usuarioid'];
    final int? idNivel = args?['nivel'];

    if (insignia == null || usuarioId == null || idNivel == null) {
      return const Scaffold(
        body: Center(child: Text('No se pudo cargar la medalla o datos incompletos')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                insignia.imagen,
                width: 200,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/buho4.png', width: 200, height: 200);
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: Center(
                  child: Text(
                    "Ganaste la medalla: ${insignia.nombre}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              boton(
                data: "Continuar",
                onPressed: () {
                  control.verificarLogrosYRedirigir(context, usuarioId, idNivel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
