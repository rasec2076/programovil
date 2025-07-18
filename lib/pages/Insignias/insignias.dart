import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/Insignias/insignias_controller.dart';
import 'package:prueba_seminario1/pages/inpeccionarInsignias/inspeccionarInsignias.dart';

class InsigniasPage extends StatelessWidget {
  final InsigniaController controller = Get.put(InsigniaController());

  InsigniasPage({super.key});

  Widget buildGrid(List<Medalla> items, BuildContext context, String tipo) {
    double itemWidth = (MediaQuery.of(context).size.width - 64) / 3;

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            tipo == 'logros'
                ? "🔒 Aún no has obtenido logros personales."
                : "🔒 Aún no has obtenido medallas.",
            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: items.map((m) {
        final esImagenDeRed = m.imagen.startsWith('http');

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InspeccionarInsigniaPage(insignia: m),
              ),
            );
          },
          child: Container(
            width: itemWidth,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                esImagenDeRed
                    ? Image.network(
                        m.imagen,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      )
                    : Image.asset(
                        m.imagen.isNotEmpty ? m.imagen : 'assets/imagen.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                const SizedBox(height: 6),
                Text(
                  m.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SesionController sesion = Get.find<SesionController>();
    final Usuario? user = sesion.getUsuario;

    if (user != null && controller.medallas.isEmpty && controller.logros.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.cargarInsignias(user.id);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDABD87),
        title: const Text("Medallas"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Logros Personales",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                buildGrid(controller.logros, context, 'logros'),

                const SizedBox(height: 20),
                const Text(
                  "Medallas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                buildGrid(controller.medallas, context, 'medallas'),
              ],
            ),
          );
        }),
      ),
    );
  }
}

