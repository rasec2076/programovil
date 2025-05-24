class Pregunta {
  int id;
  String nombre;
  int idNivel;

  Pregunta({
    required this.id,
    required this.nombre,
    required this.idNivel,
  });

  factory Pregunta.fromJson(Map<String, dynamic> json) {
    return Pregunta(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      idNivel: json['idnivel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'idnivel': idNivel,
    };
  }

  @override
  String toString() {
    return 'Pregunta{id: $id, nombre: $nombre, idNivel: $idNivel}';
  }
}
