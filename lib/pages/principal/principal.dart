import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/modulos/modulos_controller.dart';
import 'package:prueba_seminario1/pages/principal/principal_controller.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/card.dart';
import 'package:prueba_seminario1/componets/nivelcomponent.dart';
import 'package:prueba_seminario1/data/usuario.dart';

class Principal extends StatefulWidget {
  Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final PrincipalController control = Get.put(PrincipalController());
  final ModulosController control1 = Get.put(ModulosController());
  

  @override
  void initState() {
    super.initState();
    control1.initialFetch(context);
    control.initialFetchSeccion(context);
    control.initialFetchNivel(context);
  }
  

  @override
  Widget build(BuildContext context) {
    final SesionController sesion = Get.find<SesionController>();
    final Usuario? user = sesion.getUsuario;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDABD87),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("assets/buho3.png", width: 40, height: 40),
                const SizedBox(width: 5),
                Text("nivel ${user!.nivelexperiencia.toString()}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Image.asset("assets/corazon.png", width: 30, height: 30),
                const SizedBox(width: 5),
                Text(user.vidas.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      body: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: const Color(0xFFEED89B),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Cardcustom(
                        texto1: control1.seleccionado.value?.nombre ?? "Aritmetica",
                        textos2: "Hola",
                        onTap: () {
                          control1.Moduloseleccionado(context, control1.seleccionado.value);
                          Navigator.pushReplacementNamed(context, '/Modulos');
                        },
                      ),
                    ),
                    
                    Expanded(
                      child: Obx(() {
                        final idModulo = control1.seleccionado.value?.id??1 ;
                        final items = control.buildSectionedLevels(idModulo);// Aquí usas la función combinada
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            if (item["type"] == "section") {
                              // Renderiza el título de la sección
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Text(
                                    item["title"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // Renderiza el nivel
                              final nivelData = item["data"] as Nivel;
                              final isDark = index % 2 != 0;
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: index % 2 == 0
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        control.irInicioNivel(context, nivelData);
                                      },
                                      child: Nivelcomponent(isDark: isDark, nivelData: nivelData),
                          ),
                        ],
                      ),
                    );

                          }
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFDABD87),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Niveles'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Insignias'),
        ],
      ),
    );
  }
}


















