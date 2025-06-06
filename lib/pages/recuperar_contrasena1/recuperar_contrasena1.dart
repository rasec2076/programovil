import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/Iconobuho.dart';
import 'package:prueba_seminario1/componets/textfieldhint.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/pages/recuperar_contrasena1/recuperar_contrasena1_controller.dart';

class RecuperarContrasena1 extends StatelessWidget {
  final RecuperarContrasena1Controller control = Get.put(RecuperarContrasena1Controller());

  RecuperarContrasena1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(30, 80, 30, 10),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconoBuho(),
              const SizedBox(height: 30),
              const Text(
                "Recuperar Contraseña",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              const SizedBox(height: 30),
              textfieldconhint(
                controller: control.correoController,
                tipo: TextInputType.emailAddress,
                hintText: "Correo",
              ),
              const SizedBox(height: 30),
              boton(
                data: "Siguiente",
                onPressed: () async {
                  bool valido = await control.validarCorreo();
                  if (valido) {
                    Navigator.pushNamed(context, '/recuperar_contrasena2');
                  } else {
                    Get.snackbar(
                      "Error",
                      "Correo no encontrado",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
