import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/seccion.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/servicios/servicioNivel.dart';
import 'package:prueba_seminario1/servicios/servicioSeccion.dart';

class PrincipalController extends GetxController {

    final SeccionService servicioSeccion = SeccionService();
    final NivelService servicioNivel = NivelService();
    final seccion = <Seccion>[].obs;
    final  nivel = <Nivel>[].obs;

    void initialFetchSeccion(BuildContext context) async {
    Future<ServiceHttpResponse?> response = servicioSeccion.fetchAll();
    ServiceHttpResponse? result = await response;
    if(result == null){
      print('no hay respuesta del servidor');
    }else{
      if(result.status == 200){
        seccion.value = result.body;
        print('Modulos cargados: ${seccion.length}');// estoy sacando la lista de quizzes
      }else{
        print('error en la respuesta de servidor');
      }
    }
  }


    void initialFetchNivel(BuildContext context) async {
    Future<ServiceHttpResponse?> response = servicioNivel.fetchAll();
    ServiceHttpResponse? result = await response;
    if(result == null){
      print('no hay respuesta del servidor');
    }else{
      if(result.status == 200){
        nivel.value = result.body;
        print('Modulos cargados: ${nivel.length}');
      }else{
        print('error en la respuesta de servidor');
      }
    }
  }

  List<Map<String, dynamic>> buildSectionedLevels(int idModuloSeleccionado) {
  List<Map<String, dynamic>> result = [];

  // Filtrar secciones por módulo
  final seccionesFiltradas = seccion.where((s) => s.idmodulo == idModuloSeleccionado).toList();

  for (final seccion in seccionesFiltradas) {
    result.add({
      "type": "section",
      "title": seccion.nombre,
    });

    // Filtrar niveles que pertenecen a esta sección
    final nivelesFiltrados = nivel.where((n) => n.idseccion == seccion.id).toList();

    for (final nivel in nivelesFiltrados) {
      result.add({
        "type": "nivel",
        "data": nivel,
      });
    }
  }

  return result;
}


  void irInicioNivel (BuildContext context, Nivel nivelData){
      Navigator.pushNamed(context, '/inicioquiz', arguments: nivelData);
      
  }


  


  }

  
