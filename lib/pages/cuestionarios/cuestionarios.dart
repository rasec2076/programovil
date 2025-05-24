import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/pages/cuestionarios/cuestionarios_controller.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';

class Cuestionarios extends StatefulWidget {
  const Cuestionarios({super.key});

  @override
  State<Cuestionarios> createState() => _CuestionariosState();
}

class _CuestionariosState extends State<Cuestionarios> {
  final CuestionariosController control = Get.put(CuestionariosController());

  @override
  Widget build(BuildContext context) {
    final SesionController sesion = Get.find<SesionController>();
    final Usuario? user = sesion.getUsuario;

    final args = ModalRoute.of(context)?.settings.arguments;
    final List<Map<String, dynamic>> preguntasConRespuestas = (args is List<Map<String, dynamic>>) ? args : [];

    if (preguntasConRespuestas.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('❌ No hay preguntas para este nivel'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Obx(() {
            final pregunta = preguntasConRespuestas[control.preguntaActual.value]["pregunta"];
            final List respuestas = preguntasConRespuestas[control.preguntaActual.value]["respuestas"];
            double progreso = (control.preguntaActual.value + 1) / preguntasConRespuestas.length;

            return Column(
              children: [
                // 🟢 Barra de progreso y vidas
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progreso,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Image.asset("assets/corazon.png", width: 30, height: 30),
                        const SizedBox(width: 5),
                        Text(
                          user?.vidas.toString() ?? '0',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Image.asset("assets/mate.png", height: 220, width: double.infinity),
                const SizedBox(height: 30),

                Text(
                  pregunta.nombre,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                for (final r in respuestas)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        control.seleccion(context,r);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9C29C),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: Text(r.respuesta),
                    ),
                  ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    control.siguientePregunta(context, preguntasConRespuestas);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  ),
                  child: const Text("Confirmar", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
