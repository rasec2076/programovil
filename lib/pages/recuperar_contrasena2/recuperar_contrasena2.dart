import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/Iconobuho.dart';
import 'package:prueba_seminario1/componets/textfieldhint.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/pages/recuperar_contrasena2/recuperar_contrasena2_controller.dart';

class RecuperarContrasena2 extends StatelessWidget {
  final RecuperarContrasena2Controller control = RecuperarContrasena2Controller();

  RecuperarContrasena2({super.key});

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
                controller: control.nuevaController,
                tipo: TextInputType.text,
                hintText: "Nueva contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              textfieldconhint(
                controller: control.repetirController,
                tipo: TextInputType.text,
                hintText: "Repetir contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 30),
              boton(
                data: "Guardar Cambios",
                onPressed: () async {
                  final cambiado = await control.cambiarContrasena();

                  if (cambiado) {
                    print("✅ Contraseña cambiada correctamente.");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Contraseña cambiada con éxito."),
                        backgroundColor: Colors.green,
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    print("❌ Error: Contraseñas no coinciden o fallo en el proceso.");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error: Las contraseñas no coinciden."),
                        backgroundColor: Colors.red,
                      ),
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
