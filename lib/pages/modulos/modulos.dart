import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/card.dart';
import 'package:prueba_seminario1/pages/modulos/modulos_controller.dart';


class ModulosPage extends StatefulWidget {
  @override
  _ModulosState createState() => _ModulosState();
}

class _ModulosState extends State<ModulosPage> {
  
  ModulosController control = Get.put(ModulosController());


 @override
Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/principal',
        (route) => false, // 🔁 elimina toda la pila
      );
      return false; // 🔙 evita el pop normal
    },
    child: Scaffold(
      backgroundColor: const Color(0XFFEED89B),
      appBar: AppBar(
        backgroundColor:  const Color(0XFFEED89B),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/principal',
              (route) => false,
            );
          },
        ),
        title: const Text('Selecciona un Módulo'),
      ),
      body: Obx(() {
        if (control.modulos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: control.modulos.length,
         itemBuilder: (context, index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // ⬅️ agrega margen horizontal
    child: Cardcustom(
      texto1: control.modulos[index].nombre,
      textos2: "",
      onTap: () {
        control.Moduloseleccionado(context, control.modulos[index]);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seleccionaste: ${control.modulos[index].nombre}')),
        );
      },
    ),
  );
},
          
        );
      }),
    ),
  );
}
  
}


