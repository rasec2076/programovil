class UsuarioProgreso {
  int id;
  bool completado;
  int intentos;
  int aciertos;
  int idusuario;
  int idnivel;

  UsuarioProgreso({
    required this.id,
    required this.completado,
    required this.intentos,
    required this.aciertos,
    required this.idusuario,
    required this.idnivel,
  });

  factory UsuarioProgreso.fromJson(Map<String, dynamic> json) {
    return UsuarioProgreso(
      id: json['id'] ?? 0,
      completado: json['completado'] ?? false,
      intentos: json['intentos'] ?? 0,
      aciertos:json['aciertos']?? 0,
      idusuario: json['idusuario'] ?? 0,
      idnivel: json['idnivel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completado': completado,
      'intentos': intentos,
      'aciertos': aciertos,
      'idusuario': idusuario,
      'idnivel': idnivel,
    };
  }

  @override
  String toString() {
    return 'UsuarioProgreso{id: $id, completado: $completado, intentos: $intentos, aciertos: $aciertos, idusuario: $idusuario, idnivel: $idnivel}';
  }
}
