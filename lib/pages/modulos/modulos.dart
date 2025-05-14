import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/card.dart';
import 'package:prueba_seminario1/pages/modulos/modulos_controller.dart';
import 'package:prueba_seminario1/pages/principal/principal.dart';

class Modulos extends StatefulWidget {
  @override
  _ModulosState createState() => _ModulosState();
}

class _ModulosState extends State<Modulos> {
  
  ModulosController control = Get.put(ModulosController());

  int? _selectedIndex; // Track selected card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecciona un Módulo')),
      body: ListView.builder(
        itemCount: control.modulos.length,
        itemBuilder: (context, index) {
          return Cardcustom(
            texto1: control.modulos[index].nombre,
            textos2: "", // Pass list of texto2
            onTap: () {
              setState(() {
                _selectedIndex = index; // Update selection
              });
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Principal(),
                    ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Seleccionaste: ${control.modulos[index].nombre}')),
              );

            },
          );
        },
      ),
    );
  }
}
