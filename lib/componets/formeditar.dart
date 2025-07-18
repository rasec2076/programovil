import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/componets/textfield.dart';
import 'package:prueba_seminario1/componets/dropdownbutton.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/pages/Registrar/registrar_controller.dart';
import 'package:prueba_seminario1/pages/editar_perfil/editar_perfil_controller.dart';
import 'package:prueba_seminario1/pages/login/login.dart';
import 'package:get/get.dart';


class FormularioEditar extends StatefulWidget {
  final EditarUsuarioController control;
  const FormularioEditar({super.key, required this.control});

  @override
  State<FormularioEditar> createState() => _FormularioEditarStateState();
}

class _FormularioEditarStateState extends State<FormularioEditar> {
  late final EditarUsuarioController control;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    control = widget.control;
  }

  String? generoTexto(int? id) {
    if (id == 1) return "Masculino";
    if (id == 2) return "Femenino";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFDABD87),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Usuario:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            textfieldcustom(controller: control.nombreController, tipo: TextInputType.text),
            const SizedBox(height: 10),
            const Text("Correo:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            textfieldcustom(controller: control.correoController, tipo: TextInputType.emailAddress),
            const SizedBox(height: 10),
            const Text("Edad:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            textfieldcustom(controller: control.edadController, tipo: TextInputType.number),
            const SizedBox(height: 10),
            const Text("Género:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            DropDownButton(
              valores: const ["Masculino", "Femenino"],
              valorSeleccionado: generoTexto(control.generoSeleccionado),
              cambio: (valor) {
                setState(() {
                  control.generoSeleccionado = valor == "Masculino" ? 1 : 2;
                });
              },
            ),
            const SizedBox(height: 20),
            boton(
                data: "Guardar Cambios",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final ok = await control.actualizarUsuario();   // ← bool
                    if (ok) {
                      Navigator.pop(context, true);                 // ← solo si salió bien
                    } else {
                      // mensaje de error opcional
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No se pudo actualizar el usuario")),
                      );
                    }
                  }
                },
          ),
          ],
        ),
      ),
    );
  }
}
