import 'package:flutter/material.dart';
import 'package:prueba_seminario1/pages/principal/principal_controller.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/card.dart';
import 'package:prueba_seminario1/pages/modulos/modulos.dart';

class Principal extends StatelessWidget {

   
  final PrincipalController control = Get.put(PrincipalController());

   Principal({super.key});

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      appBar: AppBar(
  backgroundColor: Color(0xFFB8A583),
  automaticallyImplyLeading: false, 
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Image.asset("assets/buho3.png", width: 40, height: 40),
          SizedBox(width: 5),
          Text("Nivel 1",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        ],
      ),
      Row(
        children: [
          Image.asset("assets/corazon.png", width: 30, height: 30),
          SizedBox(width: 5),
          Text("5",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        ],
      ),
    ],
  ),
),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width:  MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: const Color(0xFFF6E8BF),
          ),
          child: Column(
            children: [
              Center(
                child: Cardcustom(texto1:"Aritmetica" ,textos2:"Aprende a sumar", onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Modulos()),
                      
                    );
                },),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFB8A583),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Niveles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.personal_injury_rounded),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Insignias',
          ),
        ],
      ),
    );
  }
}

















