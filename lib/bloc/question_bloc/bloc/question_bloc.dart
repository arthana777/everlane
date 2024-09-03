
import 'package:everlane/bloc/question_bloc/bloc/question_event.dart';
import 'package:everlane/bloc/question_bloc/bloc/question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/qst_service.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QstService qstService;

  QuestionBloc(this.qstService) : super(QstInitial()) {
    on<UpdateQuestion>(_onUpdateQuestion);
  }

  Future<void> _onUpdateQuestion(
    UpdateQuestion event,
    Emitter<QuestionState> emit,
  ) async {
    emit(QuestionLoading());
    try {
      String message = await qstService.updateUserQuestion(event.data);
      if (message.contains("Failed")) {
        emit(QuestionError(message));
      } else {
        emit(QuestionUpdated());
      }
    } catch (e) {
      emit(QuestionError(e.toString()));
    }
  }
}
