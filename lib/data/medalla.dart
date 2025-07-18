class Medalla {
  int id;
  String nombre;
  String descripcion;
  String imagen;
  int idTipo; // Cambia 'tipo' por 'idTipo' y cambia el tipo a int

  Medalla({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.idTipo,
  });

  factory Medalla.fromJson(Map<String, dynamic> json) {
    return Medalla(
      id: json["id"] ?? 0,
      nombre: json["nombre"] ?? "",
      descripcion: json["descripcion"] ?? "",
      imagen: json["imagen"] ?? "",
      idTipo: json["id_tipo"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagen': imagen,
      'id_tipo': idTipo,
    };
  }

  @override
  String toString() {
    return 'Medalla{id: $id, nombre: $nombre, idTipo: $idTipo}';
  }
}