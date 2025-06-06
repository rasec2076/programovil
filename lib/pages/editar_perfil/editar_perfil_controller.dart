import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/usuario.dart';

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class EditarUsuarioController {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  int? generoSeleccionado;

  void cargarUsuario(Usuario usuario) {
    nombreController.text = usuario.nombre;
    correoController.text = usuario.correo;
    contrasenaController.text = usuario.contrasena;
    edadController.text = usuario.edad.toString();
    generoSeleccionado = usuario.idgenero;
  }

  Usuario construirUsuarioEditado(Usuario original) {
    return Usuario(
      id: original.id,
      nombre: nombreController.text,
      correo: correoController.text,
      contrasena: contrasenaController.text,
      edad: int.tryParse(edadController.text) ?? original.edad,
      vidas: original.vidas,
      experiencia: original.experiencia,
      nivelexperiencia: original.nivelexperiencia,
      idgenero: generoSeleccionado ?? original.idgenero,
    );
  }


}
Future<void> guardarCambiosEnJson(Usuario usuarioEditado) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/usuario.json';
  final file = File(path);

  if (!await file.exists()) {
    // Si el archivo no existe aún (primera vez), lo copia desde assets o lo crea vacío
    await file.create(recursive: true);
    await file.writeAsString(jsonEncode([]));
  }

  final contenido = await file.readAsString();
  final data = jsonDecode(contenido) as List;

  final index = data.indexWhere((u) => u['id'] == usuarioEditado.id);
  if (index != -1) {
    data[index] = usuarioEditado.toJson();
  } else {
    data.add(usuarioEditado.toJson());
  }

  await file.writeAsString(jsonEncode(data));
}