
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/forgot_password_service.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordService authRepository;

  ForgotPasswordBloc({required this.authRepository})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    print("ForgotPasswordRequested event verununde");
    emit(ForgotPasswordLoading());
    try {
      print("success vernd");
      await authRepository.forgotPassword(event.username);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      print('poyii guuyd');
      emit(ForgotPasswordFailure(error: e.toString()));
    }
  }
}
