

class Conductor {
  final String nombre;
  final String patente;
  final String auto;
  final String foto;

  Conductor({
    required this.nombre,
    required this.patente,
    required this.auto,
    required this.foto,
  });

  factory Conductor.fromJson(Map<String, dynamic> json) {
    final conductorJson = json['conductor'] as Map<String, dynamic>?;  //Obtener el objeto de conductor para acceder a sus propiedades

    if (conductorJson != null) {
      return Conductor(
        nombre: conductorJson['nombre'] as String? ?? '',
        patente: conductorJson['patente'] as String? ?? '',
        auto: conductorJson['auto'] as String? ?? '',
        foto: conductorJson['foto'] as String? ?? '',
      );
    } else {
      throw const FormatException('Error al obtener datos del conductor desde el JSON.');
    }
  }

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'patente': patente,
    'auto': auto,
    'foto': foto,
  };
}
