class Genero {
  int id;
  String nombre;

  Genero({
    required this.id,
    required this.nombre,
  });

  factory Genero.fromJson(Map<String, dynamic> json) {
    return Genero(
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
    return 'Genero{id: $id, nombre: $nombre}';
  }
}
