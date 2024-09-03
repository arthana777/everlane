import 'package:equatable/equatable.dart';

import '../../data/models/userregistration.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}
class RegisterUser extends SignupEvent {
  final Userregistration user;
  
  const RegisterUser(this.user);

  @override
  List<Object> get props => [user];
}
