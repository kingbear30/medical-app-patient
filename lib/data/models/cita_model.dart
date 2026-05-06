enum EstadoCita {
  pendiente,
  confirmada,
  completada,
  cancelada;

  static EstadoCita fromString(String value) {
    return EstadoCita.values.firstWhere(
      (e) => e.name == value,
      orElse: () => EstadoCita.pendiente,
    );
  }
}

class CitaModel {
  final String id;
  final String pacienteId;
  final DateTime fechaHoraInicio;
  final EstadoCita estado;
  final String? motivoConsulta;

  CitaModel({
    required this.id,
    required this.pacienteId,
    required this.fechaHoraInicio,
    required this.estado,
    this.motivoConsulta,
  });

  factory CitaModel.fromJson(Map<String, dynamic> json) {
    return CitaModel(
      id: json['id'] as String,
      pacienteId: json['paciente_id'] as String,
      fechaHoraInicio: DateTime.parse(json['fecha_hora_inicio'] as String),
      estado: EstadoCita.fromString(json['estado'] as String),
      motivoConsulta: json['motivo_consulta'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paciente_id': pacienteId,
      'fecha_hora_inicio': fechaHoraInicio.toIso8601String(),
      'estado': estado.name,
      'motivo_consulta': motivoConsulta,
    };
  }
}
