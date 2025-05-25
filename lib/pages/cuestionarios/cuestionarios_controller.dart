import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/seccion.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
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


    int get indexPreguntaActual => preguntaActual.value;
    bool get mostrarFeedbackActivo => mostrarFeedback.value;
    bool get esRespuestaCorrecta => estadoRespuesta;
    String get textoRespuestaCorrecta => respuestaCorrecta?.respuesta ?? '';

    void initialFetchPregunta(BuildContext context) async {
    Future<ServiceHttpResponse?> response = serviciopregunta.fetchAll();
    ServiceHttpResponse? result = await response;
    if(result == null){
      print('no hay respuesta del servidor');
    }else{
      if(result.status == 200){
        preguntas.value = result.body;
        print('Prreguntas cargados: ${preguntas.length}');// estoy sacando la lista de quizzes
      }else{
        print('error en la respuesta de servidor');
      }
    }
  }


    void initialFetchRespuesta(BuildContext context) async {
    Future<ServiceHttpResponse?> response = serviciorespuesta.fetchAll();
    ServiceHttpResponse? result = await response;
    if(result == null){
      print('no hay respuesta del servidor');
    }else{
      if(result.status == 200){
        respuestas.value = result.body;
        print('Respuestas cargados: ${respuestas.length}');
      }else{
        print('error en la respuesta de servidor');
      }
    }
  }

  void irPrincipal (BuildContext context){
      Navigator.pushNamed(context, '/principal');
  }


  void siguientePregunta(BuildContext context, List<Map<String, dynamic>> preguntasConRespuestas, Usuario? user) {
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
  respuestaCorrecta = respuestas.firstWhere((r) => r.correcta == true);

  estadoRespuesta = seleccionada.correcta;
  mostrarFeedback.value = true;

  estadoRespuesta= seleccionada.correcta;
  mostrarFeedback.value = true;
}

void continuar(BuildContext context, List<Map<String, dynamic>> preguntasConRespuestas, Usuario? user) {
  final respuesta = estadoRespuesta ;

  if (respuesta == false ) {
    user!.vidas -= 1;
  }

  if (user!.vidas == 0) {
    user.vidas = 3;
    preguntaActual.value = 0;
    mostrarFeedback.value = false;
    Navigator.pushNamed(context, '/fincuestionario');
    return;
  }

  if (preguntaActual.value < preguntasConRespuestas.length - 1) {
    preguntaActual.value++;
    respuestaSeleccionada.value = null;
    mostrarFeedback.value = false;
  } else {
    user.vidas = 3;
    preguntaActual.value = 0;
    mostrarFeedback.value = false;
    Navigator.pushNamed(context, '/cuestionariocorrecto');
  }
}



  void seleccion (BuildContext context, Respuesta respuesta){
    respuestaSeleccionada.value = respuesta;
  }


void confirmarSalida(BuildContext context) async {
  final salir = await showModalBottomSheet<bool>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: const Color (0xFFEED89B),
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/principal',
      (route) => false,
    );
  }
}
}