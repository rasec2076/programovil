class UsuarioProgreso {
   final int id;
  final bool completado;
  final int intentos;
  final int aciertos;
  final int errores;
  final int tiempo;
  final int idusuario;
  final int idnivel;

  UsuarioProgreso({
    required this.id,
    required this.completado,
    required this.intentos,
    required this.aciertos,
    this.errores = 0,
    this.tiempo = 0,
    required this.idusuario,
    required this.idnivel,
  });

  factory UsuarioProgreso.fromJson(Map<String, dynamic> json) {
  return UsuarioProgreso(
    id: int.parse(json['id'].toString()),
    completado: json['completado'] == true || json['completado'] == 1,
    intentos: int.parse(json['intentos'].toString()),
    aciertos: int.parse(json['aciertos'].toString()),
    errores: int.parse(json['errores']?.toString() ?? '0'),
    tiempo: int.parse(json['tiempo']?.toString() ?? '0'),
    idusuario: int.parse(json['id_usuario'].toString()),
    idnivel: int.parse(json['id_nivel'].toString()),
  );
}
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completado': completado,
      'intentos': intentos,
      'aciertos': aciertos,
      'errores': errores,
      'tiempo': tiempo,
      'id_usuario': idusuario,
      'id_nivel': idnivel,
    };
  }

  @override
  String toString() {
    return 'UsuarioProgreso{id: $id, completado: $completado, tiempo:$tiempo, errores:$errores, intentos: $intentos, aciertos: $aciertos, idusuario: $idusuario, idnivel: $idnivel}';
  }
}
