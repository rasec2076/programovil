class Medalla {
  int id;
  String nombre;
  String descripcion;
  String tipo;
  String imagen;

  Medalla({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tipo,
    required this.imagen,
  });

  factory Medalla.fromJson(Map<String, dynamic> json) {
    return Medalla(
      id: json["id"] ?? 0,
      nombre: json["nombre"] ?? "",
      descripcion: json["descripcion"] ?? "",
      tipo: json["tipo"] ?? "",
      imagen: json["imagen"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'tipo': tipo,
      'imagen': imagen,
    };
  }

  @override
  String toString() {
    return 'Insignia{id: $id, nombre: $nombre, tipo: $tipo}';
  }
}