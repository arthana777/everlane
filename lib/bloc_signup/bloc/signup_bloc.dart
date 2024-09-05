import 'package:everlane/bloc_signup/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/signuprepository.dart';
import 'signup_event.dart';

class RegistrationBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepository;

  RegistrationBloc(this.signupRepository) : super(RegistrationInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(RegistrationLoading());
      // try {
      final data = await signupRepository.registerUser(event.user);

      if (data == "Success") {
        emit(RegistrationSuccess(data));
      } else {
        
        emit(RegistrationFailed(data));
      }
      // } catch (e) {
      //   emit(RegistrationFailed("faileddd"));
      // }
    });
  }
}
