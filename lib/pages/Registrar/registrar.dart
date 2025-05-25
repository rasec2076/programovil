import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/Iconobuho.dart';
import 'package:prueba_seminario1/componets/formresgitro.dart';
import 'package:prueba_seminario1/pages/Registrar/registrar_controller.dart';
import 'package:get/get.dart';


class Registrar extends StatelessWidget {
  
  final RegistrarController control = Get.put(RegistrarController());


   Registrar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body:Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(30, 80, 30, 10),
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                iconoBuho(),
                SizedBox(height: 10,),
                Text("Registro", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
                SizedBox(height: 10,),
                FormularioRegistro(),
                
              ],
              
            ),
          ),
      )
      
    );
  }
}