import 'package:get/get.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/servicios/servicioUsuario.dart';


class PerfilController extends GetxController {
  final usuarios = <Usuario>[].obs;
  final UsuarioService usuarioService = UsuarioService();

  void initialFetch() async {
    Future<ServiceHttpResponse?> response = usuarioService.fetchAllusuarios();
    ServiceHttpResponse? result = await response;
    if (result == null) {
      print(' No hay respuesta del servidor');
      
    }else{

    if (result.status == 200) {
      List<Usuario> lista = List<Usuario>.from(result.body);
      lista.sort((a, b) => b.experiencia.compareTo(a.experiencia));

      usuarios.value = lista;
      print(' Usuarios cargados: ${usuarios.length}');
    } else {
      print('Error en la respuesta del servidor');
    }
  }}

  void actualizarExperiencia(int usuarioId, int experienciaGanada) {
    final usuario = usuarios.firstWhere(
      (u) => u.id == usuarioId,
    );

    if (usuario != null) {
      usuario.experiencia += experienciaGanada; // Sumar la experiencia ganada
      usuarios.refresh(); // Refrescar la lista para actualizar la UI
      print('Experiencia actualizada: ${usuario.nombre}, ${usuario.experiencia} XP');
    } else {
      print('Usuario no encontrado');
    }
  }
  
}