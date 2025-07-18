import 'package:get/get.dart';
import 'package:prueba_seminario1/servicios/servicioUsuario.dart';
import '../data/usuario.dart';

class SesionController extends GetxController {
  final UsuarioService servicio = UsuarioService();
  final usuario = Rxn<Usuario>();
  final token = RxnString(); // ← añadimos token como campo separado

  void setUsuario(Usuario u, {String? authToken}) {
    usuario.value = u;
    if (authToken != null) token.value = authToken;
  }

  Usuario? get getUsuario => usuario.value;
  String? get getToken => token.value;

  void limpiarSesion() {
    usuario.value = null;
    token.value = null;
  }

   Future<void> actualizardatos() async {
    if (usuario.value == null || token.value == null) return;

    final response = await servicio.obtenerUsuarioPorId(usuario.value!.id, token.value!);

    if (response != null && response.status == 200) {
      final nuevoUsuario = response.body as Usuario;
      usuario.value = nuevoUsuario; // esto actualiza automáticamente todos los widgets que usen Obx()
    } else {
      print("❌ Error al actualizar usuario");
    }
  }
}
