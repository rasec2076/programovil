import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/data/usuarioprogreso.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/cuestionariocorrecto/cuestionariocorrecto_controller.dart';
import 'package:prueba_seminario1/pages/perfil/perfil_controller.dart';


class Cuestionariocorrecto extends StatelessWidget {


  CuestionariocorrectoController control = Get.put(CuestionariocorrectoController());
  PerfilController control1= Get.put(PerfilController());
  Cuestionariocorrecto({super.key});

 

  @override
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context)?.settings.arguments;
       if (args == null || args is! Map<String, dynamic>) {
  return const Scaffold(
    body: Center(
      child: Text('❌ No hay datos para este nivel'),
    ),
  );
  
  
}

  final SesionController sesion = Get.find<SesionController>();
    final Usuario? user = sesion.getUsuario;
    final UsuarioProgreso progress = args ["progreso"] ;
    final experienciaGanada = args["experiencia"];
    
   return  Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/buho5.png', width: 200, height: 200),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 150,
                child: Center(
                  child: Text(
                    "Buen trabajo sigue asi para mejorar tu nivel matemático",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
               SizedBox(height: 50),     // 🟡 Tarjetas de EXP y ACIERTOS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // EXP TOTAL
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Column(
                      children: [
                        Text("EXP TOTAL", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text(" ${experienciaGanada.toString()}"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  // ACIERTOS
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text("ACIERTOS", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text(" ${progress.aciertos.toString()}"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              boton(
                data: "Finalizar",
                onPressed: () {
                  control.irPrincipal(context,experienciaGanada, user!.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}