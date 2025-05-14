import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/modulo.dart';
import 'package:prueba_seminario1/servicios/servicioModulo.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';


class ModulosController extends GetxController {

  final ModuloService moduloService = ModuloService();
  var modulos = <Modulos>[].obs;
  

  void initialFetch(BuildContext context) async {
    Future<ServiceHttpResponse?> response = moduloService.fetchAll();
    ServiceHttpResponse? result = await response;
    if(result == null){
      print('no hay respuesta del servidor');
    }else{
      if(result.status == 200){
        modulos.value = result.body; // estoy sacando la lista de quizzes
      }else{
        print('error en la respuesta de servidor');
      }
    }
  }





}