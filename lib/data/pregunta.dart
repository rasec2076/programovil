class Pregunta {
  int id;
  String pregunta;
  int idNivel;

  Pregunta({
    required this.id,
    required this.pregunta,
    required this.idNivel,
  });

  factory Pregunta.fromJson(Map<String, dynamic> json) {
    return Pregunta(
      id: json['id'] ?? 0,
      pregunta: json['pregunta'] ?? '',
      idNivel: json['id_nivel'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pregunta': pregunta,
      'idnivel': idNivel,
    };
  }

  @override
  String toString() {
    return 'Pregunta{id: $id, pregunta: $pregunta, idNivel: $idNivel}';
  }
}
