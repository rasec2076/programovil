import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/componets/textfield.dart';
import 'package:prueba_seminario1/componets/dropdownbutton.dart';
import 'package:prueba_seminario1/pages/Registrar/registrar_controller.dart';
import 'package:prueba_seminario1/pages/login/login.dart';
import 'package:get/get.dart';

class FormularioRegistro extends StatefulWidget {
  final RegistrarController control;
  const FormularioRegistro({super.key, required this.control});

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroStateState();
}

class _FormularioRegistroStateState extends State<FormularioRegistro> {
  final RegistrarController control = Get.put(RegistrarController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFDABD87),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Usuario:",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            textfieldcustom(
              controller: control.nombreController,
              tipo: TextInputType.text,
            ),
            const SizedBox(height: 10),
            Text(
              "Correo:",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            textfieldcustom(
              controller: control.emailController,
              tipo: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            Text(
              "Contraseña:",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            textfieldcustom(
              controller: control.passwordController,
              tipo: TextInputType.text,
            ),
            const SizedBox(height: 10),
            Text(
              "Edad:",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            textfieldcustom(
              controller: control.edadController,
              tipo: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Text(
              "Género:",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropDownButton(
              valores: ["Masculino", "Feminino"],
              cambio: (valor) {
                setState(() {
                  control.Genero = valor;
                });
              },
              valorSeleccionado: control.Genero,
            ),
            const SizedBox(height: 20),
            boton(
              data: "Registrar",
              onPressed: () {
                control.registrar(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
