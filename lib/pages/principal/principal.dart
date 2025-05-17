import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/pages/modulos/modulos_controller.dart';
import 'package:prueba_seminario1/pages/principal/principal_controller.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/card.dart';

class Principal extends StatefulWidget {
  Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final PrincipalController control = Get.put(PrincipalController());
  final ModulosController control1 = Get.put(ModulosController());

  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    control1.initialFetch(context);
    control.initialFetchSeccion(context);
    control.initialFetchNivel(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB8A583),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("assets/buho3.png", width: 40, height: 40),
                const SizedBox(width: 5),
                const Text("Nivel 1", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Image.asset("assets/corazon.png", width: 30, height: 30),
                const SizedBox(width: 5),
                const Text("5", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                  color: const Color(0xFFF6E8BF),
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
    final items = control.buildSectionedLevels(); // Aquí usas la función combinada
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEAD9B5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    nivelData.nombre,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
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
        backgroundColor: const Color(0xFFB8A583),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Niveles'),
          BottomNavigationBarItem(icon: Icon(Icons.personal_injury_rounded), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Insignias'),
        ],
      ),
    );
  }
}


















