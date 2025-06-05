import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/pages/perfil/perfil_controller.dart'; // Asegúrate de tenerlo en tu carpeta controllers

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<Perfil> {
  final sesion = Get.find<SesionController>();
  final PerfilController control = Get.put(PerfilController());

  @override
  void initState() {
    super.initState();
    control.initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    final Usuario? usuario = sesion.getUsuario;

    return Scaffold(
      backgroundColor: const Color(0xFFEBD49C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
             
              Container(
                height: 200,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0XFFEAD9B5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Alinea verticalmente el texto y el icono
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center, // Centra el texto verticalmente
                        children: [
                          Text(
                            'Usuario: ${usuario?.nombre ?? "Desconocido"}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text('Género: ${usuario?.idgenero ?? "-"}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          Text('Edad: ${usuario?.edad ?? "-"}',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          Text('Experiencia: ${usuario?.experiencia ?? 0} XP',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                    ),  // Reduce el espacio entre el icono y el texto
                    const Icon(Icons.person, size:80), // Mantén el icono a la derecha
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Botón editar (a implementar si deseas)
              boton(data: "Editar", onPressed:() {
                
              },),

              const SizedBox(height: 12),
              const Text(
                "Ranking de Usuarios",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              // Lista deslizable de usuarios
              Expanded(
                child: Obx(() {
                  final lista = control.usuarios;
                  if (lista.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      final user = lista[index];
                      return Card(
                        color:const Color(0XFFEAD9B5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          leading: Text('${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          title: Text(user.nombre,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20) ),
                          subtitle: Text('Edad: ${user.edad}, Género: ${user.idgenero}',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          trailing: Text('${user.experiencia} XP', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}