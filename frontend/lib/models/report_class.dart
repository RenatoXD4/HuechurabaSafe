
class Reporte {
  final int id;
  final String razonReporte;
  final String nombreUsuario;
  final String patente;
  final String comentarios; 

  Reporte({
    required this.id,
    required this.razonReporte,
    required this.patente,
    required this.comentarios, 
    required this.nombreUsuario, 
  });

  factory Reporte.fromJson(Map<String, dynamic> json) {
    return Reporte(
      id: json['id'],
      razonReporte: json['razon_reporte'],
      nombreUsuario: json['nombre_usuario'],
      comentarios: json['comentarios'],
      patente: json['patente_conductor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'razon_reporte': razonReporte,
      'nombre_usuario': nombreUsuario,
      'comentarios': comentarios,
      'patente_conductor': patente,
    };
  }
}