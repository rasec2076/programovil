import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/nivel.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/modulos/modulos_controller.dart';
import 'package:prueba_seminario1/pages/principal/principal_controller.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/card.dart';
import 'package:prueba_seminario1/componets/nivelcomponent.dart';

class Principal extends StatefulWidget {
  Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final PrincipalController control = Get.put(PrincipalController());
  final ModulosController control1 = Get.put(ModulosController());
  final SesionController sesion = Get.find<SesionController>();

  @override
  void initState() {
    super.initState();
    sesion.actualizardatos(); // 🔄 Actualiza al entrar
    control1.initialFetch(context);
    final idModulo = control1.seleccionado.value?.id ?? 1;
    control.cargarItems(idModulo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDABD87),
        automaticallyImplyLeading: false,
        title: Obx(() {
          final user = sesion.getUsuario;
          if (user == null) {
            return const Text("Cargando...");
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset("assets/buho3.png", width: 40, height: 40),
                  const SizedBox(width: 5),
                  Text(
                    "nivel ${user.nivelExperiencia}",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset("assets/corazon.png", width: 30, height: 30),
                  const SizedBox(width: 5),
                  Text(
                    user.vidas.toString(),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          );
        }),
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
                  textos2: "",
                  onTap: () {
                    control1.Moduloseleccionado(context, control1.seleccionado.value);
                    Navigator.pushReplacementNamed(context, '/Modulos');
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  final items = control.items;
                  if (items.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      if (item["type"] == "section") {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              item["title"],
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      } else {
                        final nivelData = Nivel.fromJson(item["data"]);
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
                                child: Nivelcomponent(
                                  isDark: isDark,
                                  nivelData: nivelData,
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
    );
  }
}


















