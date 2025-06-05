import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/seccion.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/servicios/servicioNivel.dart';
import 'package:prueba_seminario1/servicios/servicioSeccion.dart';

class PrincipalController extends GetxController {

    final SeccionService servicioSeccion = SeccionService();
    final NivelService servicioNivel = NivelService();
    final seccion = <Seccion>[].obs;
    final  nivel = <Nivel>[].obs;
    var items = <Map<String, dynamic>>[].obs;
    

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

  Future<void> cargarItems(int idModuloSeleccionado) async {
    final result = await buildSectionedLevels(idModuloSeleccionado);
    items.value = result;
  }
 
  Future<List<Map<String, dynamic>>> buildSectionedLevels(int idModuloSeleccionado) async {
    
    List<Map<String, dynamic>> result = [];

    final seccionesResponse = await servicioSeccion.findAllSecciones(idModuloSeleccionado);
    if (seccionesResponse?.status != 200) return result;
    final List<Seccion> seccionesFiltradas = List<Seccion>.from(seccionesResponse!.body);

    for (final seccion in seccionesFiltradas) {
      result.add({
        "type": "section",
        "title": seccion.nombre,
      });

      // Obtener niveles de la sección
      final nivelesResponse = await servicioNivel.findAllNiveles(seccion.id);
      if (nivelesResponse?.status != 200) continue;

      final List<Nivel> nivelesFiltrados = List<Nivel>.from(nivelesResponse!.body);

      for (final nivel in nivelesFiltrados) {
        result.add({
          "type": "nivel",
          "data": nivel,
        });
      }
    }

    print('🔍 buildSectionedLevels cargó ${result.length} elementos');
    print(result.map((e) => e["type"]).toList()); // Solo mu

    return result;
  }


  void irInicioNivel (BuildContext context, Nivel nivelData){
      Navigator.pushNamed(context, '/inicioquiz', arguments: nivelData );
      
  }


  


  }

  
