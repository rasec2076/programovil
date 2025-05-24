import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/seccion.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/servicios/servicioPreguntas.dart';
import 'package:prueba_seminario1/servicios/servicioRespuestas.dart';



class InicioNivelController extends GetxController {

  final RespuestaService serviciorespuesta = RespuestaService();
  final PreguntaService serviciopregunta = PreguntaService();
    final preguntas = <Pregunta>[].obs;
    final  respuestas = <Respuesta>[].obs;

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
  

  void irNivel(BuildContext context, Nivel nivelData) {
  // 1. Filtrar preguntas del nivel
  final preguntasDelNivel = preguntas.where((p) => p.idNivel == nivelData.id).toList();

  // 2. Asociar respuestas a cada pregunta
  final preguntasConRespuestas = preguntasDelNivel.map((pregunta) {
    final respuestasDePregunta =
        respuestas.where((r) => r.idPregunta == pregunta.id).toList();

    return {
      "pregunta": pregunta,
      "respuestas": respuestasDePregunta,
    };
  }).toList();

   if (preguntasConRespuestas.isEmpty) {
    print('❌ No se encontraron preguntas para el nivel ${nivelData.id}');
  }

  // 3. Navegar y enviar los datos al quiz
  Navigator.pushNamed(
    context,
    '/quiz',
    arguments: preguntasConRespuestas,
  );
}



  void irPrincipal (BuildContext context){
      Navigator.pushNamed(context, '/principal');
  }




}