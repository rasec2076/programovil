import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/card.dart';
import 'package:prueba_seminario1/pages/principal/principal.dart';
import 'package:prueba_seminario1/data/modulo.dart';

class Modulos extends StatefulWidget {
  @override
  _ModulosState createState() => _ModulosState();
}

class _ModulosState extends State<Modulos> {
  // Data structure: each module has a texto1 and a list of textos2


  int? _selectedIndex; // Track selected card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecciona un Módulo')),
      body: ListView.builder(
        itemCount: modulos.length,
        itemBuilder: (context, index) {
          return Cardcustom(
            texto1: modulos[index],
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
                SnackBar(content: Text('Seleccionaste: ${modulos[index]}')),
              );

            },
          );
        },
      ),
    );
  }
}
