import 'package:equatable/equatable.dart';
import '../../../data/models/paciente_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final PacienteModel paciente;

  const AuthAuthenticated(this.paciente);

  @override
  List<Object?> get props => [paciente];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
