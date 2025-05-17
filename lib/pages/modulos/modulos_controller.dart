import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/modulo.dart';
import 'package:prueba_seminario1/servicios/servicioModulo.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';


class ModulosController extends GetxController {

  final ModuloService moduloService = ModuloService();
  var modulos = <Modulos>[].obs;
  var seleccionado = Rxn<Modulos>();
  

  void initialFetch(BuildContext context) async {
    Future<ServiceHttpResponse?> response = moduloService.fetchAll();
    ServiceHttpResponse? result = await response;
    if(result == null){
      print('no hay respuesta del servidor');
    }else{
      if(result.status == 200){
        modulos.value = result.body;
        print('Modulos cargados: ${modulos.length}');// estoy sacando la lista de quizzes
      }else{
        print('error en la respuesta de servidor');
      }
    }
  }

  void Moduloseleccionado (BuildContext context, Modulos? modulo){
  
    if (modulo != null){
          seleccionado.value= modulo;
          Navigator.pushReplacementNamed(context, '/principal');
          print(
          "Distrito seleccionado: ${seleccionado.value!.id} - ${seleccionado.value!.nombre}");
    }else{
        print("Distrito no seleccionado");
    }
    }






}