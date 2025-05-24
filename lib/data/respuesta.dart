class Respuesta {
  int id;
  String respuesta;
  bool correcta;
  int idPregunta;

  Respuesta({
    required this.id,
    required this.respuesta,
    required this.correcta,
    required this.idPregunta,
  });

  factory Respuesta.fromJson(Map<String, dynamic> json) {
    return Respuesta(
      id: json['id'] ?? 0,
      respuesta: json['respuesta'] ?? '',
      correcta: json['correcta'] ?? false,
      idPregunta: json['idpregunta'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'respuesta': respuesta,
      'correcta': correcta,
      'idpregunta': idPregunta,
    };
  }

  @override
  String toString() {
    return 'Respuesta{id: $id, respuesta: $respuesta, correcta: $correcta, idPregunta: $idPregunta}';
  }
}
