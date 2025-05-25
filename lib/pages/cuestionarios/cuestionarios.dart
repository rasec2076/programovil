import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/componets/opcion.dart';
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
    final List<Map<String, dynamic>> preguntasConRespuestas =
        (args is List<Map<String, dynamic>>) ? args : [];

    if (preguntasConRespuestas.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('❌ No hay preguntas para este nivel'),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        control.confirmarSalida(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEED89B),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 100),
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Obx(() {
                  final pregunta = preguntasConRespuestas[control.indexPreguntaActual]["pregunta"];
                  final List respuestas = preguntasConRespuestas[control.indexPreguntaActual]["respuestas"];
                  double progreso = (control.indexPreguntaActual + 1) / preguntasConRespuestas.length;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progreso,
                              minHeight: 15,
                              backgroundColor: Colors.grey[300],
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              Image.asset("assets/corazon.png", width: 30, height: 30),
                              const SizedBox(width: 5),
                              Text(
                                user?.vidas.toString() ?? '0',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      for (final r in respuestas)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: opcion(
                            onPressed: () {
                              control.seleccion(context, r);
                            },
                            data: r.respuesta,
                          ),
                        ),
                      const SizedBox(height: 50),
                      Obx(() {
                        if (!control.mostrarFeedbackActivo) {
                          return boton(
                            data: 'Confirmar',
                            onPressed: () {
                              control.siguientePregunta(
                                  context, preguntasConRespuestas, user);
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ],
                  );
                }),
              ),
            ),
            Obx(() {
              if (control.mostrarFeedbackActivo) {
                final esCorrecta = control.esRespuestaCorrecta ;
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: esCorrecta ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Text(esCorrecta? 'Respuesta correcta, la respuesta si es:  ${control.textoRespuestaCorrecta}': ' Respuesta incorrecta, la respuesta era: ${control.textoRespuestaCorrecta}',
                              style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          boton(
                            onPressed: () {
                              control.continuar(
                                  context, preguntasConRespuestas, user);
                            },
                            data: "Continuar",
                          ),

                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
