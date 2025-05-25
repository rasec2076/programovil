import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/pages/Inicio_nivel/inicio_nivel_controller.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/pages/fincuestionarios/fincuestionarios_controller.dart';

class FinalCuestionarios extends StatelessWidget {


  FincuestionariosController control = Get.put(FincuestionariosController());
  FinalCuestionarios({super.key});

 

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/buho4.png', width: 200, height: 200),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 150,
                child: Center(
                  child: Text(
                    "Perdiste todas tus vidas vuelve a intentarlo",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 200),
              boton(
                data: "Finalizar",
                onPressed: () {
                  control.irPrincipal(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}