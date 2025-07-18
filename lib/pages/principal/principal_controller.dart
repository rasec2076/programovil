import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/data/seccion.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/servicios/servicioModulo.dart';
import 'package:prueba_seminario1/servicios/servicioNivel.dart';
import 'package:prueba_seminario1/servicios/servicioSeccion.dart';

class PrincipalController extends GetxController {

    final SeccionService servicioSeccion = SeccionService();
    final NivelService servicioNivel = NivelService();
    final ModuloService servicioModulo= ModuloService();
    final seccion = <Seccion>[].obs;
    final  nivel = <Nivel>[].obs;
    var items = <Map<String, dynamic>>[].obs;
    

  Future<void> cargarItems(int idModuloSeleccionado) async {
    final result = await buildSectionedLevels(idModuloSeleccionado);
    items.value = result;
  }
 
 Future<List<Map<String, dynamic>>> buildSectionedLevels(int idModuloSeleccionado) async {
  List<Map<String, dynamic>> result = [];

  final response = await servicioModulo.findEstructuraCompleta(idModuloSeleccionado);

  if (response?.status == 200) {
    // Ya está estructurado desde el backend
    result = List<Map<String, dynamic>>.from(response!.body);
    print('✅ buildSectionedLevels recibió ${result.length} elementos');
  } else {
    print('❌ Error al obtener la estructura del módulo');
  }

  return result;
}


  void irInicioNivel (BuildContext context, Nivel nivelData){
      Navigator.pushNamed(context, '/inicioquiz', arguments: nivelData );
      
  }


  


  }

  
