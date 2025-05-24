import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/componets/textfield.dart';
import 'package:prueba_seminario1/pages/login/login_controller.dart';
import 'package:get/get.dart';




class FormularioDemoState extends StatefulWidget {
  final LoginController control;

  const FormularioDemoState({super.key, required this.control});

  @override
  State<FormularioDemoState> createState() => _FormularioDemoStateState();
}

class _FormularioDemoStateState extends State<FormularioDemoState> {
  final LoginController control = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDABD87), // Fondo similar al de la imagen
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Usuario",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: textfieldcustom(
                controller: control.nombreController,
                tipo: TextInputType.text,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Contraseña",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: textfieldcustom(
                controller: control.contrasenaController,
                tipo: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: boton(data:"Ingresar", onPressed: () {
                  control.login(context);
              }, )),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                    onTap: () {
                      control.cambiarContrasena(context);
                    },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: Colors.black,  
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                          ) 
                      )
                    )
            )
          ],
        ),
      ),
    );
  }
}


