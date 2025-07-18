import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/seccion.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/data/usuarioprogreso.dart';
import 'package:prueba_seminario1/servicios/servicioPreguntas.dart';
import 'package:prueba_seminario1/servicios/servicioRespuestas.dart';



class CuestionariosController extends GetxController {
    final RespuestaService serviciorespuesta = RespuestaService();
  final PreguntaService serviciopregunta = PreguntaService();
    final preguntas = <Pregunta>[].obs;
    final  respuestas = <Respuesta>[].obs;
    bool estadoRespuesta = false; // null = sin responder, true = correcto, false = incorrecto
    var mostrarFeedback = false.obs; // controla la visibilida
    var respuestaSeleccionada = Rxn<Respuesta>(); // para guardar la respuesta seleccionada
    var preguntaActual = 0.obs; // índice actual de pregunta  
    Respuesta? respuestaCorrecta;
    final Stopwatch cronometro = Stopwatch();


    int get indexPreguntaActual => preguntaActual.value;
    bool get mostrarFeedbackActivo => mostrarFeedback.value;
    bool get esRespuestaCorrecta => estadoRespuesta;
    String get textoRespuestaCorrecta => respuestaCorrecta?.respuesta ?? '';



  void irPrincipal (BuildContext context){
      Navigator.pushNamed(context, '/principal');
  }


  void siguientePregunta(BuildContext context, List<Map<String, dynamic>> preguntasConRespuestas, Usuario? user, UsuarioProgreso progress) {
  final seleccionada = respuestaSeleccionada.value;

  if (seleccionada == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Debes seleccionar una respuesta"),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  final respuestas = preguntasConRespuestas[preguntaActual.value]["respuestas"] as List<Respuesta>;
  respuestas.firstWhere((r) => r.correcta == true);

  estadoRespuesta = seleccionada.correcta;
  mostrarFeedback.value = true;

  
  
}

void continuar(
  BuildContext context,
  List<Map<String, dynamic>> preguntasConRespuestas,
  Usuario? user,
  UsuarioProgreso progress,
  

) async {
  final response = await serviciopregunta.responderPregunta(
    idUsuario: user!.id,
    idNivel: progress.idnivel,
    idRespuesta: respuestaSeleccionada.value!.id,
  );

  if (response?.status != 200) {
    print('Error al responder la pregunta');
    return;
  }

  final data = response!.body as Map<String, dynamic>;

  final int vidasRestantes = data['vidasRestantes'];
  final bool nivelCompletado = data['nivelCompletado'] ?? false;
  final int experienciaGanada = data['experienciaGanada']?? 0 ;
  final bool reiniciado = data['reiniciado'] ?? false;
  final int aciertos = data['aciertos'] ?? 0;

  user.vidas = vidasRestantes;
  

  if (reiniciado) {
    preguntaActual.value = 0;
    mostrarFeedback.value = false;
    Navigator.pushNamed(context, '/fincuestionario', arguments: progress);
    return;
  }

if (!nivelCompletado && preguntaActual.value + 1 < preguntasConRespuestas.length) {
  // Solo si hay más preguntas
  preguntaActual.value++;
  respuestaSeleccionada.value = null;
  mostrarFeedback.value = false;
} else if (nivelCompletado) {
  cronometro.stop();
  preguntaActual.value = 0;
  mostrarFeedback.value = false;
  Navigator.pushNamed(
    context,
    '/cuestionariocorrecto',
    arguments: {
      "idusuario": user.id,
      "idnivel": progress.idnivel,
      "aciertos": aciertos,
      "vidasRestantes": user.vidas,
      "experienciaGanada": experienciaGanada,

    },
  );
}
}



  void seleccion (BuildContext context, Respuesta respuesta){
    respuestaSeleccionada.value = respuesta;
  }


void confirmarSalida(BuildContext context, int idUsuario, int idNivel) async {
  final salir = await showModalBottomSheet<bool>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: const Color(0xFFEED89B),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "¿Deseas salir del quiz?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Si sales ahora, perderás tu progreso actual.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                  ),
                  child: const Text("Seguir aprendiendo", style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                  ),
                  child: const Text("Salir"),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  if (salir == true) {
    final response = await serviciopregunta.reiniciarCuestionario(
      idUsuario: idUsuario,
      idNivel: idNivel,
    );

    if (response?.status == 200) {
      print("✅ Progreso reiniciado correctamente");

      // ✅ También reiniciar el estado local del cuestionario
      preguntaActual.value = 0;
      respuestaSeleccionada.value = null;
      mostrarFeedback.value = false;
      cronometro.reset();

    } else {
      print("❌ Error al reiniciar progreso: ${response?.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hubo un problema al reiniciar el cuestionario"),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Redirigir a Home igual, incluso si falló
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/Home',
      (route) => false,
    );
  }
}
}