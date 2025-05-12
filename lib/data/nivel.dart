class Nivel {
  int id;
  String nombre;
  int idseccion;

  Nivel({
    required this.id,
    required this.nombre,
    required this.idseccion,
  });

  factory Nivel.fromJson(Map<String, dynamic> json) {
    return Nivel(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      idseccion: json['idseccion'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'idseccion': idseccion,
    };
  }

  @override
  String toString() {
    return 'Nivel{id: $id, nombre: $nombre, idseccion: $idseccion}';
  }
}