import 'package:equatable/equatable.dart';
import '../../../data/models/cita_model.dart';

abstract class CitasState extends Equatable {
  const CitasState();

  @override
  List<Object?> get props => [];
}

class CitasInitial extends CitasState {}

class CitasLoading extends CitasState {}

class CitasSuccess extends CitasState {
  final List<CitaModel> citas;
  final List<DateTime> fechasDisponibles;

  const CitasSuccess({
    this.citas = const [],
    this.fechasDisponibles = const [],
  });

  @override
  List<Object?> get props => [citas, fechasDisponibles];
}

class CitasFailure extends CitasState {
  final String error;

  const CitasFailure(this.error);

  @override
  List<Object?> get props => [error];
}
