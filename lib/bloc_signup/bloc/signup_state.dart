import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends SignupState {}

class RegistrationLoading extends SignupState {}

class RegistrationSuccess extends SignupState {}

class RegistrationFailed extends SignupState {
  final String error;

  const RegistrationFailed(this.error);

  @override
  List<Object> get props => [error];
}


