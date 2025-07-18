class UsuarioInsignia {
  final int id;
  final int idUsuario;
  final int idInsignia;

  UsuarioInsignia({
    required this.id,
    required this.idUsuario,
    required this.idInsignia,
  });

  factory UsuarioInsignia.fromJson(Map<String, dynamic> json) {
    return UsuarioInsignia(
      id: json['id'],
      idUsuario: json['id_usuario'],
      idInsignia: json['id_insignia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_usuario': idUsuario,
      'id_insignia': idInsignia,
    };
  }
}