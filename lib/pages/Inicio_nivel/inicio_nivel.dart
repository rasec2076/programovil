import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/pages/Inicio_nivel/inicio_nivel_controller.dart';
import 'package:get/get.dart';

class InicioNivel extends StatelessWidget {


  InicioNivelController control = Get.put(InicioNivelController());
  InicioNivel({super.key});

 

  @override
  Widget build(BuildContext context) {
  control.initialFetchPregunta(context);
  control.initialFetchRespuesta(context);
  final nivelData = ModalRoute.of(context)!.settings.arguments as Nivel;
   return  Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/buo1.PNG', width: 150, height: 150),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 150,
                child: Center(
                  child: Text(
                    "Supera esta prueba para saltar  a la siguiente etapa",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 200),
              boton(
                data: "Empezar",
                onPressed: () {
                  control.irNivel(context,nivelData);
                },
              ),
              SizedBox(height: 20,),
              Center(
              child: GestureDetector(
                    onTap: () {
                    control.irPrincipal(context);
                    },
                      child: Text(
                        'Ahora no',
                        style: TextStyle(
                          color: Colors.black,  
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                          ) 
                      )
                    )
            )
            ],
          ),
        ),
      ),
    );
  }
}