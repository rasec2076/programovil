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
    var seccion = <Seccion>[].obs;
    var nivel = <Nivel>[].obs;

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

  List<Map<String, dynamic>> buildSectionedLevels() {
  final items = <Map<String, dynamic>>[];

  for (var sec in seccion) {
    items.add({"type": "section", "title": sec.nombre});
    final nivelesDeLaSeccion = nivel.where((n) => n.idseccion == sec.id);
    for (var nivel in nivelesDeLaSeccion) {
      items.add({"type": "level", "data": nivel});
    }
  }

  return items;

  }


  


  }

  
