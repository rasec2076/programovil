import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/data/usuarioprogreso.dart';
import 'package:prueba_seminario1/servicios/servicioPreguntas.dart';
import 'package:prueba_seminario1/servicios/servicioRespuestas.dart';
import 'package:prueba_seminario1/servicios/servicioUsuarioProgreso.dart';



class InicioNivelController extends GetxController {
final  UsuarioProgresoService usuarioProgresoservice = UsuarioProgresoService();
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
  

Future<void> irNivel(BuildContext context, Nivel nivelData, Usuario? user) async {
  // 1. Obtener preguntas del nivel
 final preguntasResponse = await serviciopregunta.findAllPreguntasPorNivel(nivelData.id);
  if (preguntasResponse?.status != 200 || preguntasResponse!.body.isEmpty) {
    print(' No se encontraron preguntas para el nivel ${nivelData.id}');
    return;
  }

  final List<Pregunta> preguntasDelNivel = List<Pregunta>.from(preguntasResponse.body);

  // 2. Para cada pregunta, obtener sus respuestas
  final List<Map<String, dynamic>> preguntasConRespuestas = [];

  for (final pregunta in preguntasDelNivel) {
    final respuestasResponse = await serviciorespuesta.findAllRespuestasPorPregunta(pregunta.id);
    final respuestas = (respuestasResponse?.status == 200)
        ? List<Respuesta>.from(respuestasResponse!.body)
        : <Respuesta>[];

    preguntasConRespuestas.add({
      "pregunta": pregunta,
      "respuestas": respuestas,
    });
  }

  // 3. Obtener el progreso, si no existe, crear uno con valores por defecto
  final progresoResponse = await usuarioProgresoservice.findProgresoPorUsuarioYNivel(user!.id, nivelData.id);
  UsuarioProgreso progreso;
  if (progresoResponse?.status == 200) {
    progreso = progresoResponse!.body;
  } else {
    print('Progreso no encontrado, creando uno nuevo por defecto');
    progreso = UsuarioProgreso(
      id: 0, // o algún id temporal
      completado: false,
      intentos: 0,
      aciertos: 0,
      idusuario: user.id,
      idnivel: nivelData.id,
    );
  }

  // 4. Navegar y enviar TODO en arguments
  Navigator.pushNamed(
    context,
    '/quiz',
    arguments: {
      "preguntas": preguntasConRespuestas,
      "progreso": progreso,
      "usuario": user,
      "nivel": nivelData,
    },
  );
}



  void irPrincipal (BuildContext context){
      Navigator.pushNamed(context, '/Home');
  }




}