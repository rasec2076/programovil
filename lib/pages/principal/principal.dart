import 'package:flutter/material.dart';
import 'package:prueba_seminario1/pages/principal/principal_controller.dart';
import 'package:get/get.dart';

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
                child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                 onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ModuleSelectionScreen()),
                    );
                  },
                  child: Container(
                  width: 350,
                  height: 120,
                  padding: EdgeInsets.all(16),
                  child: Row(
                  children: [
                      Icon(Icons.dashboard, size: 40),
                      SizedBox(width: 20),
                      Column(mainAxisAlignment: MainAxisAlignment.center
                        ,children: [
                        Text('Seleccionar Módulo',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text("Sección 1")
                      ], ) 
                  ],
                  ),
                  ),
                ),
              ),
              )
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


class ModuleSelectionScreen extends StatelessWidget {
  final List<String> modules = [
    'Módulo de Usuarios',
    'Módulo de Ventas',
    'Módulo de Reportes',
    'Módulo de Inventario'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecciona un Módulo')),
      body: ListView.builder(
        itemCount: modules.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Card(child:Container(
                  width: 350,
                  height: 120,
                  padding: EdgeInsets.all(16),
                  child: Row(
                  children: [
                      Icon(Icons.dashboard, size: 40),
                      SizedBox(width: 20),
                      Text(modules[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                  ),
                  ),),
            onTap: () {
              // Aquí puedes hacer la navegación al módulo correspondiente
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Seleccionaste: ${modules[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}