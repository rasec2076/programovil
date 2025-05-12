class Usuario {
  int id;
  String nombre;
  String correo;
  String contrasena;
  int edad;
  int vidas;
  int experiencia;
  int nivelexperiencia;
  int idgenero;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.edad,
    required this.vidas,
    required this.experiencia,
    required this.nivelexperiencia,
    required this.idgenero,
  });

  factory Usuario.fromJson(Map<String, dynamic> usuario) {
    return Usuario(
      id: usuario["id"] ?? 0,
      nombre: usuario["nombre"] ?? "",
      correo: usuario["correo"] ?? "",
      contrasena: usuario["contrasena"] ?? "",
      edad: usuario["edad"] ?? 0,
      vidas: usuario["vidas"] ?? 0,
      experiencia: usuario["experiencia"] ?? 0,
      nivelexperiencia: usuario["nivelexperiencia"] ?? 0,
      idgenero: usuario["idgenero"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
      'edad': edad,
      'vidas': vidas,
      'experiencia': experiencia,
      'nivelexperiencia': nivelexperiencia,
      'idgenero': idgenero,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nombre: $nombre, correo: $correo, contrasena: $contrasena, edad: $edad, vidas: $vidas, experiencia: $experiencia, nivelexperiencia: $nivelexperiencia, idgenero: $idgenero}';
  }
}
