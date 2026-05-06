class ResultadoMedicoModel {
  final String id;
  final String pacienteId;
  final String tituloAnalisis;
  final String rutaArchivoStorage;
  final String? observaciones;
  final DateTime fechaSubida;

  ResultadoMedicoModel({
    required this.id,
    required this.pacienteId,
    required this.tituloAnalisis,
    required this.rutaArchivoStorage,
    this.observaciones,
    required this.fechaSubida,
  });

  factory ResultadoMedicoModel.fromJson(Map<String, dynamic> json) {
    return ResultadoMedicoModel(
      id: json['id'] as String,
      pacienteId: json['paciente_id'] as String,
      tituloAnalisis: json['titulo_analisis'] as String,
      rutaArchivoStorage: json['ruta_archivo_storage'] as String,
      observaciones: json['observaciones'] as String?,
      fechaSubida: DateTime.parse(json['fecha_subida'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paciente_id': pacienteId,
      'titulo_analisis': tituloAnalisis,
      'ruta_archivo_storage': rutaArchivoStorage,
      'observaciones': observaciones,
      'fecha_subida': fechaSubida.toIso8601String(),
    };
  }
}
