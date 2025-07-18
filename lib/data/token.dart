class Token {
  int id;
  String token;
  DateTime createdAt;
  DateTime updatedAt;
  int usuarioId;

  Token({
    required this.id,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    required this.usuarioId,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json["id"] ?? 0,
      token: json["token"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      usuarioId: json["usuarioId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'usuarioId': usuarioId,
    };
  }

  @override
  String toString() {
    return 'Token{id: $id, token: $token, createdAt: $createdAt, updatedAt: $updatedAt, usuarioId: $usuarioId}';
  }
}