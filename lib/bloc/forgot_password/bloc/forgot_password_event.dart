// forgot_password_event.dart
import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String username;

  const ForgotPasswordRequested(this.username);

  @override
  List<Object> get props => [username];
}