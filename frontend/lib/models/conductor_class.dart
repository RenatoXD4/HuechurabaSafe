

class Conductor {
  final int id;
  final String nombre;
  final String patente;
  final String auto;
  final String foto;

  Conductor({
    required this.id,
    required this.nombre,
    required this.patente,
    required this.auto,
    required this.foto,
  });

  factory Conductor.fromJson(Map<String, dynamic> json) {
    return Conductor(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      patente: json['patente'] ?? '',
      auto: json['auto'] ?? '',
      foto: json['foto'] ?? '',
    );
  }

  static List<Conductor> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Conductor.fromJson(json)).toList();
  }
}