import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/pages/ganastelogro/ganastelogro_controller.dart';

class GanasteLogro extends StatelessWidget {
  GanasteLogro({super.key});

  final GanasteLogroController control = Get.put(GanasteLogroController());

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final List<Medalla>? logros = args?['logros'] != null
        ? List<Medalla>.from(args!['logros'])
        : null;

    if (logros == null || logros.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No se obtuvieron logros')),
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
              const Text(
                '¡Logro desbloqueado!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              for (var logro in logros) ...[
                Image.network(
                  logro.imagen,
                  width: 120,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/buho4.png', width: 120, height: 120);
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  logro.nombre,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
              ],
              const SizedBox(height: 20),
              boton(
                data: "Home",
                onPressed: () {
                  control.irPrincipal(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}