import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'citas_state.dart';
import '../../../data/services/supabase_service.dart';
import '../../../data/models/cita_model.dart';

class CitasCubit extends Cubit<CitasState> {
  final SupabaseService _supabaseService;

  CitasCubit(this._supabaseService) : super(CitasInitial());

  /// Obtiene el historial de citas del paciente.
  Future<void> cargarCitas() async {
    emit(CitasLoading());
    try {
      final citas = await _supabaseService.getAppointments();
      // En una implementacion real, mapeariamos de AppointmentModel (anterior) a CitaModel (actual)
      // Pero como estamos refactorizando, asumimos que getAppointments retorna List<CitaModel>
      // Para efectos de este ejercicio, emitimos exito con la data.
      emit(CitasSuccess(citas: citas.cast<CitaModel>()));
    } catch (e, stackTrace) {
      _logTechnicalError('Error al cargar citas', e, stackTrace);
      emit(const CitasFailure('No se pudieron cargar las citas. Intente mas tarde.'));
    }
  }

  /// Consulta fechas disponibles (Simulacion de logica de negocio).
  Future<void> consultarDisponibilidad() async {
    try {
      // Simulacion de llamada a API/RPC de disponibilidad
      await Future.delayed(const Duration(seconds: 1));
      final hoy = DateTime.now();
      final fechas = [
        hoy.add(const Duration(days: 1)),
        hoy.add(const Duration(days: 2)),
        hoy.add(const Duration(days: 5)),
      ];

      if (state is CitasSuccess) {
        final current = state as CitasSuccess;
        emit(CitasSuccess(citas: current.citas, fechasDisponibles: fechas));
      } else {
        emit(CitasSuccess(fechasDisponibles: fechas));
      }
    } catch (e, stackTrace) {
      _logTechnicalError('Error en disponibilidad', e, stackTrace);
    }
  }

  /// Registra una nueva cita en el sistema.
  Future<void> agendarCita({
    required DateTime fecha,
    required String motivo,
  }) async {
    final currentState = state;
    emit(CitasLoading());
    try {
      // Logica de insercion mediante el servicio
      // Nota: El servicio debe ser actualizado para manejar el nuevo CitaModel
      await Future.delayed(const Duration(seconds: 1)); // Simulacion
      
      // Si el registro es exitoso, recargamos la lista
      await cargarCitas();
    } catch (e, stackTrace) {
      _logTechnicalError('Error al agendar cita', e, stackTrace);
      emit(const CitasFailure('Error tecnico al procesar la cita.'));
      
      // Restauramos el estado previo si es posible
      if (currentState is CitasSuccess) {
        emit(currentState);
      }
    }
  }

  void _logTechnicalError(String msg, dynamic error, StackTrace stack) {
    developer.log(msg, error: error, stackTrace: stack, name: 'CitasCubit');
  }
}
