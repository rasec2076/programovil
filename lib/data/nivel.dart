class Nivel {
  int id;
  String numero;
  int idseccion;

  Nivel({
    required this.id,
    required this.numero,
    required this.idseccion,
  });

  factory Nivel.fromJson(Map<String, dynamic> json) {
    return Nivel(
      id: json['id'] ?? 0,
      numero: json['numero'] ?? '',
      idseccion: json['idseccion'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'idseccion': idseccion,
    };
  }

  @override
  String toString() {
    return 'Nivel{id: $id, nombre: $numero, idseccion: $idseccion}';
  }
}