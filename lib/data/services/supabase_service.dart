import 'dart:developer' as developer;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/paciente_model.dart';
import '../models/cita_model.dart';
import '../models/resultado_medico_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // --- Auth Methods ---

  /// Registers a new patient: creates auth user and public patient record.
  Future<void> registrarPaciente({
    required String email,
    required String password,
    required String nombre,
    required String apellidos,
    required String cedula,
    String? telefono,
    String? arsNombre,
    String? numeroAfiliado,
  }) async {
    try {
      final AuthResponse res = await _client.auth.signUp(
        email: email,
        password: password,
      );

      final String? userId = res.user?.id;
      if (userId == null) throw Exception('No se pudo obtener el ID de usuario');

      // Create public patient record
      await _client.from('pacientes').insert({
        'id': userId,
        'nombre': nombre,
        'apellidos': apellidos,
        'cedula': cedula,
        'telefono': telefono,
        'ars_nombre': arsNombre,
        'numero_afiliado': numeroAfiliado,
      });
    } catch (e, stackTrace) {
      _logError('Error en registro de paciente', e, stackTrace);
      rethrow;
    }
  }

  /// Logs in a patient.
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
    } catch (e, stackTrace) {
      _logError('Error en inicio de sesion', e, stackTrace);
      rethrow;
    }
  }

  /// Signs out the current session.
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e, stackTrace) {
      _logError('Error al cerrar sesion', e, stackTrace);
    }
  }

  // --- Data Fetching Methods ---

  /// Retrieves appointments for the currently authenticated patient.
  Future<List<CitaModel>> getAppointments() async {
    try {
      final List<Map<String, dynamic>> response = await _client
          .from('citas')
          .select()
          .order('fecha_hora_inicio', ascending: true);

      return response.map((data) => CitaModel.fromJson(data)).toList();
    } catch (e, stackTrace) {
      _logError('Error obteniendo citas', e, stackTrace);
      return [];
    }
  }

  /// Retrieves medical results for the currently authenticated patient.
  Future<List<ResultadoMedicoModel>> getMedicalResults() async {
    try {
      final List<Map<String, dynamic>> response = await _client
          .from('resultados_medicos')
          .select()
          .order('fecha_subida', ascending: false);

      return response.map((data) => ResultadoMedicoModel.fromJson(data)).toList();
    } catch (e, stackTrace) {
      _logError('Error obteniendo resultados medicos', e, stackTrace);
      return [];
    }
  }

  // --- Helpers ---

  /// Internal logger for developer diagnostics.
  void _logError(String message, dynamic error, StackTrace stackTrace) {
    developer.log(
      message,
      error: error,
      stackTrace: stackTrace,
      name: 'SupabaseService',
    );
  }
}
