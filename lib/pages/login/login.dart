import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/form.dart';
import 'package:prueba_seminario1/pages/Registrar/registrar.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/pages/login/login_controller.dart';


class login extends StatelessWidget {
  
  final LoginController control = Get.put(LoginController());

  login({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6E8BF),
      body:Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(30, 80, 30, 10),
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipOval(child: Container(color: const Color.fromARGB(255, 42, 40, 40), width: 170,height: 170, 
                child: Image.asset(
                      'assets/buho2.png',
                      fit: BoxFit.fill, 
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Text("Iniciar Sesión", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
                SizedBox(height: 30,),
                FormularioDemoState(),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No tienes cuenta?",
                        style: TextStyle(
                          color: Colors.black, 
                          fontWeight: FontWeight.normal,
                          fontSize: 16
                        ) 
                      ),
                    GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registrar()),
                    );
                    },
                      child: Text(
                        'Registrate Aquí',
                        style: TextStyle(
                          color: Colors.black, 
                          decoration: TextDecoration.underline, 
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                          ) 
                      )
                    )
                  ],
                  )
              ],
              
            ),
          ),
      )
      
    );
  }
}





              
