class NivelInsignia {
  int id;
  int idNivel;
  int idInsignia;

  NivelInsignia({
    required this.id,
    required this.idNivel,
    required this.idInsignia,
  });

  factory NivelInsignia.fromJson(Map<String, dynamic> json) {
    return NivelInsignia(
      id: json['id'] ?? 0,
      idNivel: json['id_nivel'] ?? 0,
      idInsignia: json['id_insignia'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_nivel': idNivel,
      'id_insignia': idInsignia,
    };
  }

  @override
  String toString() {
    return 'NivelInsignia{id: $id, idNivel: $idNivel, idInsignia: $idInsignia}';
  }
}