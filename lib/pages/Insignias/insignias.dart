import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/pages/Insignias/insignias_controller.dart';
import 'package:prueba_seminario1/pages/inpeccionarInsignias/inspeccionarInsignias.dart';

class InsigniasPage extends StatelessWidget {
  final InsigniaController controller = Get.put(InsigniaController());

  InsigniasPage({super.key});

  Widget buildGrid(List<Medalla> items, BuildContext context) {
    double itemWidth = (MediaQuery.of(context).size.width - 64) / 3;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: items.map((m) {
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
                Image.asset(
                  m.imagen.isNotEmpty ? m.imagen : 'assets/imagen.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                Text(
                  m.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                buildGrid(controller.logros, context),

                const SizedBox(height: 20),
                const Text(
                  "Medallas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                buildGrid(controller.medallas, context),
              ],
            ),
          );
        }),
      ),
    );
  }
}
