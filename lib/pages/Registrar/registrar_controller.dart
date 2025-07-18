import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prueba_seminario1/servicios/servicioUsuario.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';

class RegistrarController extends GetxController {
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final edadController = TextEditingController();
  String? Genero;

  final UsuarioService usuarioservicio = UsuarioService();

  void mostrarAlertaExito(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Registro exitoso'),
          content: Text('Tu cuenta ha sido creada correctamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                ); // Redirige a /login
              },
              child: Text('Ir al login'),
            ),
          ],
        );
      },
    );
  }

    Future<void> registrar(BuildContext context) async {
    final nombre = nombreController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final edad = int.tryParse(edadController.text.trim()) ?? 0;

    if (nombre.isEmpty || email.isEmpty || password.isEmpty || edad == 0 || Genero == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Completa todos los campos antes de continuar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
          ],
        ),
      );
      return;
    }

    final nuevoUsuario = Usuario(
      id: 0,
      usuario: nombre,
      correo: email,
      contrasena: password,
      edad: edad,
      experiencia: 0,
      idgenero: Genero == 'Masculino' ? 1 : 2,
      nivelExperiencia: 0,
      vidas: 3,
    );

    final response = await usuarioservicio.crearCuenta(nuevoUsuario);

    if (response != null && response.status == 201) {
      mostrarAlertaExito(context);
    } else {
      String errorMsg = 'Error al registrar usuario.';

      if (response != null && response.body is Map<String, dynamic>) {
        final Map<String, dynamic> errorJson = response.body;
        if (errorJson.containsKey('message')) {
          errorMsg = errorJson['message'];
        } else if (errorJson.containsKey('error')) {
          errorMsg = errorJson['error'];
        }
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(errorMsg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }

}
