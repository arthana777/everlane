import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends SignupState {}

class RegistrationLoading extends SignupState {}

class RegistrationSuccess extends SignupState {
String message;

   RegistrationSuccess(this.message);

  @override
  List<Object> get props => [message];

}

class RegistrationFailed extends SignupState {
  String? message;

   RegistrationFailed(this.message);

  @override
  List<Object> get props => [message!];
}


