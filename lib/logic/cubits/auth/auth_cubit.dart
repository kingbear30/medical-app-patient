import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../../data/services/supabase_service.dart';
import '../../../data/models/paciente_model.dart';

class AuthCubit extends Cubit<AuthState> {
  final SupabaseService _supabaseService;

  AuthCubit(this._supabaseService) : super(AuthInitial());

  /// Verifica si hay una sesion activa al iniciar la app.
  Future<void> verificarSesion() async {
    emit(AuthLoading());
    try {
      // Nota: En una implementacion real, consultariamos Supabase.instance.client.auth.currentSession
      // Y si existe, cargariamos el PacienteModel desde la tabla publica.
      await Future.delayed(const Duration(seconds: 1)); // Simulacion
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  /// Inicia sesion con correo y contraseña.
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await _supabaseService.signIn(email: email, password: password);
      
      // Simulacion de carga de datos del paciente tras login exitoso
      final mockPaciente = PacienteModel(
        id: 'uuid-123',
        nombre: 'Juan',
        apellidos: 'Perez',
        cedula: '402-0000000-1',
        arsNombre: 'Senasa',
        numeroAfiliado: '987654321',
      );
      
      emit(AuthAuthenticated(mockPaciente));
    } catch (e, stackTrace) {
      _logError('Error en Login', e, stackTrace);
      emit(const AuthFailure('Credenciales invalidas o error de conexion.'));
    }
  }

  /// Cierra la sesion activa.
  Future<void> logout() async {
    try {
      await _supabaseService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  void _logError(String msg, dynamic error, StackTrace stack) {
    developer.log(msg, error: error, stackTrace: stack, name: 'AuthCubit');
  }
}
