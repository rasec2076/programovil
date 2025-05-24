import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/pages/login/login.dart';


class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/buo1.PNG', width: 150, height: 150),
              SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    "Aprende Matemáticas de una forma divertida",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 200),
              boton(
                data: "Iniciar",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}