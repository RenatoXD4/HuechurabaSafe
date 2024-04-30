class Conductor {
  final String nombreConductor;
  final String patente;
  final String tipoVehiculo;
  final String foto;

  const Conductor({
    required this.nombreConductor,
    required this.patente,
    required this.tipoVehiculo,
    required this.foto
  });

  factory Conductor.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': String userId,
        'patente': String patente,
        'tipoVehiculo': String tipoVehiculo,
        'foto': String foto
      } =>
        Conductor(
          nombreConductor: userId,
          patente: patente,
          tipoVehiculo: tipoVehiculo,
          foto: foto
        ),
      _ => throw const FormatException('No se cargó el conductor'),
    };
  }
}

