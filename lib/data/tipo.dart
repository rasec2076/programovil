class TipoMedalla {
  int id;
  String nombre;

  TipoMedalla({
    required this.id,
    required this.nombre,
  });

  factory TipoMedalla.fromJson(Map<String, dynamic> json) {
    return TipoMedalla(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  @override
  String toString() {
    return 'TipoMedalla{id: $id, nombre: $nombre}';
  }
}