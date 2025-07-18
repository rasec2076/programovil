import 'package:get/get.dart';
import 'package:prueba_seminario1/data/servicehttpresponse.dart';
import 'package:prueba_seminario1/data/usuario.dart';
import 'package:prueba_seminario1/servicios/servicioUsuario.dart';


class PerfilController extends GetxController {
  final usuarios = <Usuario>[].obs;
  final UsuarioService usuarioService = UsuarioService();

void initialFetch() async {
  ServiceHttpResponse? result = await usuarioService.obtenerTodosLosUsuarios();

  if (result == null) {
    print('❌ No hay respuesta del servidor');
  } else if (result.status == 200) {
    // ✅ Cast directo ya que en el servicio ya hiciste el .map con fromJson
    List<Usuario> lista = result.body as List<Usuario>;

    lista.sort((a, b) => b.nivelExperiencia.compareTo(a.nivelExperiencia));
    usuarios.value = lista;

    print('✅ Usuarios cargados: ${usuarios.length}');
  } else {
    print('⚠️ Error en la respuesta del servidor: ${result.status}');
  }
}


  
}