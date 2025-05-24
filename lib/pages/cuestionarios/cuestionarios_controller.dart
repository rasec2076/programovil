import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/seccion.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/servicios/servicioPreguntas.dart';
import 'package:prueba_seminario1/servicios/servicioRespuestas.dart';



class CuestionariosController extends GetxController {
    final RespuestaService serviciorespuesta = RespuestaService();
  final PreguntaService serviciopregunta = PreguntaService();
    final preguntas = <Pregunta>[].obs;
    final  respuestas = <Respuesta>[].obs;

    var respuestaSeleccionada = Rxn<Respuesta>(); // para guardar la respuesta seleccionada
    var preguntaActual = 0.obs; // índice actual de pregunta  

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
  

  void irNivel (BuildContext context){
      Navigator.pushNamed(context, '/quiz');
  }

  void irPrincipal (BuildContext context){
      Navigator.pushNamed(context, '/principal');
  }

  void siguientePregunta(BuildContext context, List<Map<String, dynamic>> preguntasConRespuestas) {
  final seleccionada = respuestaSeleccionada.value;

  if (seleccionada == null) {
    Get.snackbar("Espera", "Debes seleccionar una respuesta antes de continuar",
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  final esCorrecta = seleccionada.correcta;

  Get.snackbar(
    esCorrecta ? "¡Correcto!" : "Incorrecto",
    esCorrecta ? "Bien hecho 🎉" : "La respuesta no es correcta 😢",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: esCorrecta ? Colors.green[200] : Colors.red[200],
    duration: const Duration(seconds: 2),
  );

  // Avanzar a la siguiente pregunta después de un pequeño delay
  Future.delayed(const Duration(seconds: 2), () {
    if (preguntaActual.value < preguntasConRespuestas.length - 1) {
      preguntaActual.value++;
      respuestaSeleccionada.value = null; // reiniciar selección
    } else {
      Get.defaultDialog(
        title: "¡Finalizado!",
        middleText: "Has completado todas las preguntas.",
        onConfirm: () {
          Navigator.pushNamed(context, '/principal');
        },
        textConfirm: "Volver",
        confirmTextColor: Colors.white,
      );
    }
  });
}

  void seleccion (BuildContext context, Respuesta respuesta){
    respuestaSeleccionada.value = respuesta;
  }
}