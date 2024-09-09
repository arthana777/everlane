import 'package:everlane/bloc/forgot_password/bloc/forgot_password_event.dart';
import 'package:everlane/bloc/forgot_password/bloc/forgot_password_state.dart';
import 'package:everlane/data/datasources/forgot_password_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    emit(ForgotPasswordLoading());
    print("ForgotPasswordRequested event received");
    print("Making API call for username: ${event.username}");

    try {
      final message =
          await authRepository.forgotPassword(event.username);
      emit(ForgotPasswordSuccess(message: message));
      print("success :-${event.username}");
    } catch (e) {
      print("forgotPassword failed${event}");
      emit(ForgotPasswordFailure(message: e.toString()));
    }
  }
}
