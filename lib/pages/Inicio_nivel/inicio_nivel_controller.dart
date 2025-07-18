import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/pregunta.dart';
import 'package:prueba_seminario1/data/respuesta.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/data/usuarioprogreso.dart';
import 'package:prueba_seminario1/pages/cuestionarios/cuestionarios_controller.dart';
import 'package:prueba_seminario1/servicios/servicioPreguntas.dart';
import 'package:prueba_seminario1/servicios/servicioRespuestas.dart';
import 'package:prueba_seminario1/servicios/servicioUsuarioProgreso.dart';



class InicioNivelController extends GetxController {
final  UsuarioProgresoService usuarioProgresoservice = UsuarioProgresoService();
  final RespuestaService serviciorespuesta = RespuestaService();
  final PreguntaService serviciopregunta = PreguntaService();
    final preguntas = <Pregunta>[].obs;
    final  respuestas = <Respuesta>[].obs;
    /*final CuestionariosController cuestionarioCtrl = Get.find<CuestionariosController>();*/

  
  

Future<void> irNivel(BuildContext context, Nivel nivelData, Usuario? user) async {
  final cuestionarioResponse = await serviciopregunta.findAllCuestionarioporNivel(nivelData.id);

  if (cuestionarioResponse?.status != 200 || cuestionarioResponse!.body == null) {
    print('❌ Error al obtener cuestionario para nivel ${nivelData.id}');
    return;
  }

  final List<Pregunta> preguntas = cuestionarioResponse.body['preguntas'];
  final List<Respuesta> respuestas = cuestionarioResponse.body['respuestas'];

  final List<Map<String, dynamic>> preguntasConRespuestas = preguntas.map((pregunta) {
    final respuestasDeEsta = respuestas.where((r) => r.idPregunta == pregunta.id).toList();
    return {
      'pregunta': pregunta,
      'respuestas': respuestasDeEsta,
    };
  }).toList();

  final progresoResponse = await usuarioProgresoservice.findProgresoPorUsuarioYNivel(user!.id, nivelData.id);
  UsuarioProgreso progreso;


  if (progresoResponse?.status == 200) {
    progreso = progresoResponse!.body ;
  } else {
    print('Progreso no encontrado, creando uno...');
    final crearResponse = await usuarioProgresoservice.crearProgreso(user.id, nivelData.id);
    progreso = crearResponse!.body ;
  }

    /*cuestionarioCtrl.cronometro.reset();
    cuestionarioCtrl.cronometro.start();*/

    // Navegar con los datos completos
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