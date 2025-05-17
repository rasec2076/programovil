import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/card.dart';
import 'package:prueba_seminario1/pages/modulos/modulos_controller.dart';
import 'package:prueba_seminario1/pages/principal/principal.dart';

class ModulosPage extends StatefulWidget {
  @override
  _ModulosState createState() => _ModulosState();
}

class _ModulosState extends State<ModulosPage> {
  
  ModulosController control = Get.put(ModulosController());

  int? _selectedIndex; // Track selected card

  @override
  Widget build(BuildContext context) {
    control.initialFetch(context);
    return Scaffold(
      appBar: AppBar(title: Text('Selecciona un Módulo')),
      body: Obx(() {  // Observa cambios en la lista
        if (control.modulos.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: control.modulos.length,
          itemBuilder: (context, index) {
            return Cardcustom(
              texto1: control.modulos[index].nombre,
              textos2: "",
              onTap: () {
                control.Moduloseleccionado(context, control.modulos[index]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleccionaste: ${control.modulos[index].nombre}')),
                );
              },
            );
          },
        );
      }),
    );
  }
 
  
}


