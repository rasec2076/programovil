class Seccion {

  int id;
  String nombre;
  int idmodulo;

   Seccion({required this.id, required this.nombre, required this.idmodulo});


  factory Seccion.fromJson(Map<String, dynamic> modulo) {
  return Seccion(
      id: modulo["id"] ?? 0,
      nombre: modulo["nombre"] ?? "",
      idmodulo: modulo["idmodulo"] ?? 0,
    );
  }

  // Conversión a JSON (importante si enviarás data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'idmodulo':idmodulo,
    };
  }


  @override
  String toString() {
    return 'Distrito{id: $id, name: $nombre, iddmodulo: $idmodulo}';
  }
 
  

}