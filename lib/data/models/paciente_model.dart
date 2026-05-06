class PacienteModel {
  final String id;
  final String nombre;
  final String apellidos;
  final String cedula;
  final String? telefono;
  final String? arsNombre;
  final String? numeroAfiliado;

  PacienteModel({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.cedula,
    this.telefono,
    this.arsNombre,
    this.numeroAfiliado,
  });

  factory PacienteModel.fromJson(Map<String, dynamic> json) {
    return PacienteModel(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      apellidos: json['apellidos'] as String,
      cedula: json['cedula'] as String,
      telefono: json['telefono'] as String?,
      arsNombre: json['ars_nombre'] as String?,
      numeroAfiliado: json['numero_afiliado'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'cedula': cedula,
      'telefono': telefono,
      'ars_nombre': arsNombre,
      'numero_afiliado': numeroAfiliado,
    };
  }
}
