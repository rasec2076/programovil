import 'package:get/get.dart';
import 'package:prueba_seminario1/data/medalla.dart';
import 'package:prueba_seminario1/servicios/servicioMedallas.dart';

class InsigniaController extends GetxController {
  var medallas = <Medalla>[].obs;
  var logros = <Medalla>[].obs;

  final MedallaService _service = MedallaService();

  @override
  void onInit() {
    super.onInit();
    cargarInsignias();
  }

  void cargarInsignias() async {
    final response = await _service.fetchAll();
    if (response?.status == 200 && response?.body is List<Medalla>) {
      final todas = response!.body as List<Medalla>;
      medallas.value = todas.where((m) => m.tipo == 'medalla').toList();
      logros.value = todas.where((m) => m.tipo == 'logro').toList();
    } else {
      print("❌ Error al cargar medallas: ${response?.body}");
    }
  }
}
