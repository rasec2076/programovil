import 'package:get/get.dart';
import 'package:prueba_seminario1/data/medalla.dart';

class InspeccionarInsigniaController extends GetxController {
  final Rx<Medalla?> medallaSeleccionada = Rx<Medalla?>(null);

  void setMedalla(Medalla medalla) {
    medallaSeleccionada.value = medalla;
  }
}
