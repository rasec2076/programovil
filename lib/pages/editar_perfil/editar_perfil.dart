import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/data/genero.dart';
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
  final EditarUsuarioController controller = EditarUsuarioController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Genero> generos = [
    Genero(id: 1, nombre: "Masculino"),
    Genero(id: 2, nombre: "Femenino"),
  ];

  @override
  void initState() {
    super.initState();
    controller.cargarUsuario(widget.usuario);
  }



  @override
  Widget build(BuildContext context) {
    final SesionController sesion = Get.find<SesionController>();
    final Usuario? user = sesion.getUsuario;
    return Scaffold(
      backgroundColor: const Color(0xFFF1D59A),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1D59A),
        elevation: 0,
        title: const Text("Editar Usuario", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.person, size: 100),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.nombreController,
                decoration: const InputDecoration(labelText: 'Usuario'),
              ),
              TextFormField(
                controller: controller.correoController,
                decoration: const InputDecoration(labelText: 'Correo'),
              ),
              TextFormField(
                controller: controller.contrasenaController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),
              TextFormField(
                controller: controller.edadController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<int>(
                value: controller.generoSeleccionado,
                decoration: const InputDecoration(labelText: 'Género'),
                items: generos.map((g) {
                  return DropdownMenuItem<int>(
                    value: g.id,
                    child: Text(g.nombre),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    controller.generoSeleccionado = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Usuario usuarioEditado = controller.construirUsuarioEditado(widget.usuario);

                    await guardarCambiosEnJson(usuarioEditado);

                    Navigator.pop(context, usuarioEditado);
                  }
                },
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
