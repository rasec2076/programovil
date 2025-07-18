class Usuario {
  int id;
  String usuario;
  String correo;
  String contrasena;
  int edad;
  int vidas;
  int experiencia;
  int nivelExperiencia;
  int idgenero; // Campo adicional que solicitaste

  Usuario({
    required this.id,
    required this.usuario,
    required this.correo,
    required this.contrasena,
    required this.edad,
    required this.vidas,
    required this.experiencia,
    required this.nivelExperiencia,
    required this.idgenero,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"] ?? 0,
      usuario: json["usuario"] ?? "",
      correo: json["correo"] ?? "",
      contrasena: json["contrasenia"] ?? "",
      edad: json["edad"] ?? 0,
      vidas: json["vidas"] ?? 3,
      experiencia: json["experiencia"] ?? 0,
      nivelExperiencia: json["nivel_experiencia"] ?? 1,
  
      idgenero: json["id_genero"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario': usuario,
      'correo': correo,
      'contrasenia': contrasena,
      'edad': edad,
      'vidas': vidas,
      'experiencia': experiencia,
      'nivel_experiencia': nivelExperiencia,
      'id_genero': idgenero,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, usuario: $usuario, correo: $correo, edad: $edad, vidas: $vidas, experiencia: $experiencia, nivelExperiencia: $nivelExperiencia, idgenero: $idgenero}';
  }
}