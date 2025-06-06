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

  final UsuarioService usuarios = UsuarioService();

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

    if (nombre.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        edad == 0 ||
        Genero == null) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
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

    List<Usuario> usuarios = [];
    final String body = await rootBundle.loadString('assets/json/usuario.json');
    final List<dynamic> data = jsonDecode(body);
    usuarios =
        data
            .map((map) => Usuario.fromJson(map as Map<String, dynamic>))
            .toList();

    final nuevoUsuario = Usuario(
      id: 6,
      nombre: nombre,
      correo: email,
      contrasena: password,
      edad: edad,
      experiencia: 20,
      idgenero: Genero == 'Masculino' ? 1 : 2,
      nivelexperiencia: 0,
      vidas: 3,
    );

    usuarios.add(nuevoUsuario);

    final usuariosTexto = usuarios
        .map((u) => '${u.nombre}, ${u.correo}')
        .join('\n');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Registro exitoso'),
          content: Text('Usuarios registrados:\n\n$usuariosTexto'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // cerrar alerta
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Ir al login'),
            ),
          ],
        );
      },
    );
  }
}
