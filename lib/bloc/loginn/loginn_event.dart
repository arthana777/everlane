part of 'loginn_bloc.dart';

@immutable
sealed class LoginnEvent extends Equatable {}

class LoginButtonEvent extends LoginnEvent{
  @override
  final String username;
  final String password;

  LoginButtonEvent({required this.username, required this.password});
  List<Object?> get props => [];
}
