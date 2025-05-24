import 'package:get/get.dart';
import '../data/usuario.dart';

class SesionController extends GetxController {
  final usuario = Rxn<Usuario>(); // usuario puede ser null al inicio

  void setUsuario(Usuario u) {
    usuario.value = u;
  }

  Usuario? get getUsuario => usuario.value;
}