class Modulos {

  int id;
  String nombre;

   Modulos({required this.id, required this.nombre});


  factory Modulos.fromJson(Map<String, dynamic> modulo) {
  return Modulos(
      id: modulo["id"] ?? 0,
      nombre: modulo["nombre"] ?? "",
    );
  }

  // Conversión a JSON (importante si enviarás data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }


  @override
  String toString() {
    return 'Distrito{id: $id, name: $nombre}';
  }
 
  

}