



import 'package:everlane/bloc/question_result/bloc/question_result_event.dart';
import 'package:everlane/bloc/question_result/bloc/question_result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/qst_service.dart';
import '../../../data/models/qstresult.dart';

class QuestionResultBloc extends Bloc<QuestionResultEvent, QuestionResultState> {
  final QstService qstService;

  QuestionResultBloc(this.qstService) : super(QuestionResultInitial()) {
    on<FetchProduct>(_onFetchProduct);
  }

  Future<void> _onFetchProduct(
      FetchProduct event,
      Emitter<QuestionResultState> emit,
      ) async {
    emit(QuestionResultLoading());
    try {
      List<Qstresult> product = await qstService.fetchUserProfile();
      emit(QuestionResultLoaded(product));
    } catch (e) {
      emit(QuestionResulError(e.toString()));
    }
  }
}
