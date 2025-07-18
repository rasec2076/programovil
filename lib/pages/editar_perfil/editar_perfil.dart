import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/formeditar.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/editar_perfil/editar_perfil_controller.dart';
import 'package:get/get.dart';

class EditarUsuarioPage extends StatefulWidget {
  final Usuario usuario;

  const EditarUsuarioPage({super.key, required this.usuario});

  @override
  State<EditarUsuarioPage> createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final EditarUsuarioController controller = Get.put(EditarUsuarioController());

  @override
  void initState() {
    super.initState();
    controller.cargarUsuario(widget.usuario); // carga los datos del usuario actual
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF1D59A),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF1D59A),
      elevation: 0,
      title: const Text("Editar Usuario", style: TextStyle(color: Colors.black)),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: const Color(0XFF3F3D39),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 100),
            ),
          ),
          const SizedBox(height: 30),
          FormularioEditar(control: controller), // tu formulario
        ],
      ),
    ),
  );
}
}
