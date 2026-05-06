import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:medical_app/data/models/cita_model.dart';
import 'package:medical_app/data/services/supabase_service.dart';
import 'package:medical_app/logic/cubits/citas/citas_cubit.dart';
import 'package:medical_app/logic/cubits/citas/citas_state.dart';

class MockSupabaseService extends Mock implements SupabaseService {}

void main() {
  late CitasCubit citasCubit;
  late MockSupabaseService mockSupabaseService;

  setUp(() {
    mockSupabaseService = MockSupabaseService();
    citasCubit = CitasCubit(mockSupabaseService);
  });

  tearDown(() {
    citasCubit.close();
  });

  group('CitasCubit QA Tests', () {
    test('Estado inicial debe ser CitasInitial', () {
      expect(citasCubit.state, equals(CitasInitial()));
    });

    blocTest<CitasCubit, CitasState>(
      'Emitir [Loading, Success] cuando cargarCitas es exitoso',
      build: () {
        when(() => mockSupabaseService.getAppointments())
            .thenAnswer((_) async => <CitaModel>[]);
        return citasCubit;
      },
      act: (cubit) => cubit.cargarCitas(),
      expect: () => [
        CitasLoading(),
        const CitasSuccess(citas: []),
      ],
    );

    blocTest<CitasCubit, CitasState>(
      'Emitir [Loading, Failure] cuando hay un error de red o servidor',
      build: () {
        when(() => mockSupabaseService.getAppointments())
            .thenThrow(Exception('Error de conexion con Supabase'));
        return citasCubit;
      },
      act: (cubit) => cubit.cargarCitas(),
      expect: () => [
        CitasLoading(),
        const CitasFailure('No se pudieron cargar las citas. Intente mas tarde.'),
      ],
    );
  });
}
